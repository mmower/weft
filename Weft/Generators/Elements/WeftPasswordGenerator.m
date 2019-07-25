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

static NSString * const kPasswordElementName = @"password";

@implementation WeftPasswordGenerator

- (NSString *)elementName {
  return kPasswordElementName;
}

- (BOOL)requiresId {
  return YES;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSSecureTextField *secureField = [[NSSecureTextField alloc] init];
  secureField.weftElementId = elementId;
  secureField.weftAttributes = attributes;

  secureField.translatesAutoresizingMaskIntoConstraints = NO;
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
