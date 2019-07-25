//
//  WeftElementGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftElementGenerator.h"

#import "WeftApplication.h"

#import "WeftWindowGenerator.h"
#import "WeftButtonGenerator.h"
#import "WeftTextfieldGenerator.h"
#import "WeftRowGenerator.h"
#import "WeftColGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

NSString * const kIdAttributeName = @"id";
NSString * const kGravityAttributeName = @"gravity";
NSString * const kChoicesAttributeName = @"choices";
NSString * const kInsetsAttributeName = @"insets";
NSString * const kTitleAttributeName = @"title";
NSString * const kDisabledAttributeName = @"disabled";
NSString * const kTooltipAttributeName = @"tooltip";
NSString * const kNameAttributeName = @"name";
NSString * const kSrcAttributeName = @"src";
NSString * const kProviderAttributeName = @"provider";
NSString * const kWidthAttributeName = @"width";
NSString * const kHeightAttributeName = @"height";
NSString * const kDefaultAttributeName = @"default";
NSString * const kScrollableAttributeName = @"scrollable";
NSString * const kEditableAttributeName = @"editable";
NSString * const kSelectableAttributeName = @"selectable";
NSString * const kPlaceholderAtributeName = @"placeholder";
NSString * const kDistributionAttributeName = @"distribution";
NSString * const kDateAttributeName = @"date";

static NSMapTable *generators;

@implementation WeftElementGenerator

+ (WeftElementGenerator *)app:(WeftApplication *)app element:(NSString *)element {
  NSString *className = [NSString stringWithFormat:@"Weft%@Generator",[element capitalizedString]];
  Class generatorClass = NSClassFromString( className );
  WeftElementGenerator *generator = [[generatorClass alloc] initWithApplication:app];
  return generator;
}

- (instancetype)initWithApplication:(WeftApplication *)application {
  self = [super init];
  if( self ) {
    _app = application;
  }
  return self;
}

- (NSString *)elementName {
  @throw [NSException exceptionWithName:@"TypeError"
                                 reason:[NSString stringWithFormat:@"Subclass %@ does not define -elementName",self.className]
                               userInfo:@{@"class":self.className}];
}

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:self.elementName];
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  @throw [NSException exceptionWithName:@"TypeError"
                                 reason:[NSString stringWithFormat:@"Subclass %@ does not define -openElementAttributes:",self.className]
                               userInfo:@{@"class":self.className}];
}

- (void)closeElementText:(NSString *)foundChars {
  @throw [NSException exceptionWithName:@"TypeError"
                                 reason:[NSString stringWithFormat:@"Subclass %@ does not define -closeElementText:",self.className]
                               userInfo:@{@"class":self.className}];
}

- (NSArray *)choices:(NSDictionary *)attributes {
  WeftAttribute *attr = [attributes csvAttribute:kChoicesAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Config Error"
                                   reason:[NSString stringWithFormat:@"%@ defined without 'choices' attribute",self.elementName]
                                 userInfo:attributes];
  } else {
    return attr.csvValue;
  }
}

- (NSView *)rootView {
  return self.app.appView;
}

- (NSStackView *)currentStack {
  return self.app.currentStack;
}

- (void)addView:(NSView *)view {
  WeftAttribute *attr = [view.weftAttributes gravityAttribute:kGravityAttributeName];
  if( attr.defined ) {
    [self.app addView:view inGravity:attr.gravityValue];
  } else {
    [self.app addArrangedSubview:view];
  }
}

//- (void)autoPinWidthOfView:(NSView *)view width:(NSInteger)width {
//  [self.app.appView addConstraint:[NSLayoutConstraint constraintWithItem:view
//                                                          attribute:NSLayoutAttributeWidth
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:nil
//                                                          attribute:NSLayoutAttributeNotAnAttribute
//                                                         multiplier:1.0
//                                                           constant:width]];
//}
//
//- (void)app:(WeftApplication *)app autoPinWidthOfView:(NSView *)view attributes:(NSDictionary *)attributes {
//  WeftAttribute *attr = [attributes integerAttribute:@"width"];
//  if( attr.defined ) {
//    [self app:app autoPinWidthOfView:view width:attr.integerValue];
//  }
//}
//
//- (void)app:(WeftApplication *)app autoPinHeightOfView:(NSView *)view height:(NSInteger)height {
//  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:view
//                                                          attribute:NSLayoutAttributeHeight
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:nil
//                                                          attribute:NSLayoutAttributeNotAnAttribute
//                                                         multiplier:1.0
//                                                           constant:height]];
//}
//
//
//- (void)app:(WeftApplication *)app autoPinHeightOfView:(NSView *)view attributes:(NSDictionary *)attributes {
//  WeftAttribute *attr = [attributes integerAttribute:@"height"];
//  if( attr.defined ) {
//    [self app:app autoPinHeightOfView:view height:attr.integerValue];
//  }
//}

#pragma mark -
#pragma mark Feature generators



- (void)view:(NSView *)view shouldHaveTooltip:(NSDictionary *)attributes {
  WeftAttribute *attr = [attributes stringAttribute:kTooltipAttributeName];
  if( attr.defined ) {
    [view setToolTip:attr.stringValue];
  }
}

@end
