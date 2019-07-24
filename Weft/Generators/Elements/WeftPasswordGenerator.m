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

- (NSString *)elementName {
  return @"password";
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:kIdAttributeName];
  if( attr.defined ) {
    elementId = attr.stringValue;
  } else {
    @throw [NSException exceptionWithName:@"Password error"
                                   reason:@"<password> without 'id' attribute"
                                 userInfo:attributes];
  }




  NSSecureTextField *secureField = [[NSSecureTextField alloc] init];
  secureField.translatesAutoresizingMaskIntoConstraints = NO;
  secureField.weftAttributes = attributes;

  [self addView:secureField];

  attr = [attributes floatAttribute:kWidthAttributeName];
  if( attr.defined ) {
    [secureField pinWidth:attr.floatValue];
  }

  attr = [attributes floatAttribute:kHeightAttributeName];
  if( attr.defined ) {
    [secureField pinHeight:attr.floatValue];
  }

  [self.app registerElement:secureField];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:secureField.stringValue forKey:elementId];
  }];
}

- (void)closeElementText:(NSString *)text {
}

@end
