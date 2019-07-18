//
//  WeftTextfieldGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftTextfieldGenerator.h"

#import "WeftApplication.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

static const NSInteger kTextFieldHeight = 22;
static const NSInteger kTextFieldDefaultWidth = 280;

@implementation WeftTextfieldGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"textfield"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  NSParameterAssert(app);
  NSParameterAssert(attributes);

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
    [app addArrangedSubview:label];
  }

  NSInteger width = kTextFieldDefaultWidth;
  attr = [attributes integerAttribute:@"width"];
  if( attr.defined ) {
    width = attr.integerValue;
  }

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

  [app addArrangedSubview:textField];
  [app registerElement:textField attributes:attributes];
  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:textField.stringValue forKey:elementId];    
  }];
}

- (void)closeElementApp:(WeftApplication *)app {
}

@end
