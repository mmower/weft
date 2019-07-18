//
//  WeftPasswordGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftPasswordGenerator.h"

#import "WeftTextfieldGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftPasswordGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"password"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:@"id"];
  if( attr.defined ) {
    elementId = attr.stringValue;
  } else {
    @throw [NSException exceptionWithName:@"Password error"
                                   reason:@"<password> without 'id' attribute"
                                 userInfo:attributes];
  }

  NSInteger width;
  attr = [attributes integerAttribute:@"width"];
  if( attr.defined ) {
    width = attr.integerValue;
  } else {
    width = kTextFieldDefaultWidth;
  }

  NSInteger height;
  attr = [attributes integerAttribute:@"height"];
  if( attr.defined ) {
    height = attr.integerValue;
  } else {
    height = kTextFieldHeight;
  }

  NSSecureTextField *secureField = [[NSSecureTextField alloc] init];
  secureField.translatesAutoresizingMaskIntoConstraints = NO;
  attr = [attributes gravityAttribute:@"gravity"];
  if( attr.defined ) {
    [app addView:secureField inGravity:attr.gravityValue];
  } else {
    [app addArrangedSubview:secureField];
  }

  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:secureField
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:width]];
  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:secureField
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:height]];


  [app registerElement:secureField attributes:attributes];
  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:secureField.stringValue forKey:elementId];
  }];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
}

@end
