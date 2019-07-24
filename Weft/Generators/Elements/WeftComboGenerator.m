//
//  WeftComboGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftComboGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftComboGenerator

- (NSString *)elementName {
  return @"combo";
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Combo error"
                                   reason:@"Combo defined without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSArray *choices = [self choices:attributes];
  NSComboBox *combo = [[NSComboBox alloc] init];
  combo.translatesAutoresizingMaskIntoConstraints = NO;
  combo.weftAttributes = attributes;
  combo.completes = YES;
  [combo addItemsWithObjectValues:choices];

  attr = [attributes stringAttribute:@"default"];
  if( attr.defined ) {
    [combo selectItemWithObjectValue:attr.stringValue];
  }

  [self addView:combo];
  [self.app registerElement:combo];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:[combo stringValue] forKey:elementId];
  }];
}

- (void)closeElementText:(NSString *)foundChars {
}

@end
