//
//  WeftParser.m
//  weft
//
//  Created by Matthew Mower on 15/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftParser.h"

#import "WeftRunner.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

static const NSInteger kTextFieldHeight = 22;
static const NSInteger kTextFieldDefaultWidth = 280;

@interface WeftParser ()

@property NSMutableDictionary *attributes;
@property NSString *foundCharacters;
@property (readwrite) NSMutableArray<NSError *> *errors;
@property NSMutableArray *stackHistory;

@property NSStackView *currentStack;

@property WeftRunner *runner;

@end

@implementation WeftParser

- (instancetype)initWithRunner:(WeftRunner *)runner {
  self = [super init];
  if( self ) {
    _runner = runner;
    _errors = [NSMutableArray array];
    _stackHistory = [NSMutableArray array];
  }
  return self;
}

- (SEL)selectorForElement:(NSString *)elementName
                   prefix:(NSString *)prefix
                   suffix:(NSString *)suffix {
  NSString *methodName = [NSString stringWithFormat:@"%@%@Element%@",prefix,[elementName capitalizedString],suffix];
  return NSSelectorFromString( methodName );
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
  SEL parseSel = [self selectorForElement:elementName prefix:@"didStart" suffix:@":"];
  if( [self respondsToSelector:parseSel] ) {
    void (*func)(id,SEL,NSDictionary*) = (void*)[self methodForSelector:parseSel];
    if( func ) {
      @try {
        func(self,parseSel,attributeDict);
      }
      @catch( NSException *ex ) {
        [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                               code:1
                                           userInfo:@{@"line":@(parser.lineNumber),
                                                      @"col":@(parser.columnNumber),
                                                      @"error":[ex reason]
                                                      }]];
      }
    } else {
      @throw [NSException exceptionWithName:@"Parse Error" reason:[NSString stringWithFormat:@"Unexpected lack of implementation for selector:%@.", NSStringFromSelector(parseSel)] userInfo:nil];
    }
  } else {
    @throw [NSException exceptionWithName:@"Parse Error" reason:[NSString stringWithFormat:@"Unexpected opening element '%@' encountered.", elementName] userInfo:nil];
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  self.foundCharacters = string;
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
  self.foundCharacters = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(nonnull NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI
 qualifiedName:(nullable NSString *)qName
{
  SEL parseSel = [self selectorForElement:elementName prefix:@"didEnd" suffix:@""];
  if( [self respondsToSelector:parseSel] ) {
    void (*func)(id,SEL) = (void*)[self methodForSelector:parseSel];
    if( func ) {
      @try {
        func(self,parseSel);
      }
      @catch( NSException *ex ) {
        [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                               code:1
                                           userInfo:@{@"line":@(parser.lineNumber),
                                                      @"col":@(parser.columnNumber),
                                                      @"error":[ex reason]
                                                      }]];
      }
    } else {
      @throw [NSException exceptionWithName:@"Parse Error" reason:[NSString stringWithFormat:@"Unexpected lack of implementation for selector: %@", NSStringFromSelector(parseSel)] userInfo:nil];
    }
  }
}

#pragma mark -
#pragma mark Element Parsers

- (void)didStartWindowElement:(NSDictionary *)attributes {

  WeftAttribute *attr;

  NSInteger width;
  attr = [attributes integerAttribute:@"width"];
  if( attr.defined ) {
    width = attr.integerValue;
  } else {
    width = 500;
  }

  NSInteger height;
  attr = [attributes integerAttribute:@"height"];
  if( attr.defined ) {
    height = attr.integerValue;
  } else {
    height = 200;
  }

//  _rootView = [[WeftMainView alloc] initWithFrame:NSMakeRect(0, 0, width, height)];

  NSStackView *rootStackView;
  _rootView = rootStackView = [[NSStackView alloc] initWithFrame:NSMakeRect(0, 0, width, height)];
  attr = [attributes orientiationAttribute:@"orientation"];
  if( attr.defined ) {
    rootStackView.orientation = attr.orientationValue;
  } else {
    rootStackView.orientation = NSUserInterfaceLayoutOrientationVertical;
  }

  _currentStack = rootStackView;
  _attributes = [NSMutableDictionary dictionary];

  NSString *title = [attributes objectForKey:@"title"];
  if( title == nil ) {
    title = @"";
  }
  _attributes[@"width"] = @(width);
  _attributes[@"height"] = @(height);
  _attributes[@"title"] = title;
}

- (void)didStartHstackElement:(NSDictionary *)attributes {
  NSStackView *stackView = [[NSStackView alloc] init];
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  stackView.orientation = NSUserInterfaceLayoutOrientationHorizontal;

  WeftAttribute *attr = [attributes insetsAttribute:@"insets"];
  if( attr.defined ) {
    stackView.edgeInsets = attr.insetsValue;
  }

  [_currentStack addArrangedSubview:stackView];
  [_stackHistory addObject:_currentStack];
  _currentStack = stackView;
}

- (void)didEndHstackElement {
  _currentStack = [_stackHistory lastObject];
  [_stackHistory removeLastObject];
}

- (void)didStartVstackElement:(NSDictionary *)attributes {
  NSStackView *stackView = [[NSStackView alloc] init];
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  stackView.orientation = NSUserInterfaceLayoutOrientationVertical;

  WeftAttribute *attr = [attributes insetsAttribute:@"insets"];
  if( attr.defined ) {
    stackView.edgeInsets = attr.insetsValue;
  }

  [_currentStack addArrangedSubview:stackView];
  [_stackHistory addObject:_currentStack];
  _currentStack = stackView;
}

- (void)didEndVstackElement {
  _currentStack = [_stackHistory lastObject];
  [_stackHistory removeLastObject];
}

- (void)didStartButtonElement:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"Button without id"
                                 userInfo:nil];
  }
  NSString *elementId = attr.stringValue;

  attr = [attributes stringAttribute:@"title"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"Button without title"
                                 userInfo:nil];
  }
  NSString *title = attr.stringValue;
  NSLog( @"title = %@", title );

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:self.runner
                                        action:@selector(buttonPushed:)];
  button.translatesAutoresizingMaskIntoConstraints = NO;

  [button setElementId:elementId];

  attr = [attributes stringAttribute:@"tooltip"];
  if( attr.defined ) {
    [button setToolTip:attr.stringValue];
  }

  attr = [attributes boolAttribute:@"disabled"];
  if( attr.defined && attr.boolValue ) {
    [button setEnabled:NO];
  }

  attr = [attributes gravityAttribute:@"gravity"];
  if( !attr.defined ) {
    [_currentStack addArrangedSubview:button];
  } else {
    [_currentStack addView:button inGravity:attr.gravityValue];
  }

  NSLog( @"Added button: %@", button );
  [self.runner registerElement:button attributes:attributes];
}

- (void)didEndWindowElement {
  NSLog( @"window ENDS!" );
}

- (void)didStartTextfieldElement:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"TextField without id"
                                 userInfo:nil];
  }
  NSString *elementId = attr.stringValue;

  attr = [attributes stringAttribute:@"label"];
  if( attr.defined ) {
    NSTextField *label = [NSTextField labelWithString:attr.stringValue];
    [_currentStack addArrangedSubview:label];
//    [_currentView addSubview:label];
  }

  NSInteger width = kTextFieldDefaultWidth;
  attr = [attributes integerAttribute:@"width"];
  if( attr.defined ) {
    width = attr.integerValue;
  }
  NSLog( @"textfield.width = %ld", width );

  NSInteger height = kTextFieldHeight;
  attr = [attributes integerAttribute:@"height"];
  if( attr.defined ) {
    height = attr.integerValue;
  }

  NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, width, height)];
  textField.translatesAutoresizingMaskIntoConstraints = NO;
  [textField setElementId:elementId];

  attr = [attributes stringAttribute:@"placeholder"];
  if( attr.defined ) {
    [textField setPlaceholderString:attr.stringValue];
  }

  attr = [attributes stringAttribute:@"tooltip"];
  if( attr.defined ) {
    [textField setToolTip:attr.stringValue];
  }

  attr = [attributes boolAttribute:@"disabled"];
  if( attr.defined && attr.boolValue ) {
    [textField setEnabled:NO];
  }

  [_currentStack addArrangedSubview:textField];
//  [_stackView addView:textField inGravity:NSStackViewGravityCenter];
//  [_currentView addSubview:textField];
  [self.runner registerElement:textField attributes:attributes];
}

@end

@implementation WeftMainView

- (BOOL)isFlipped {
  return YES;
}

@end
