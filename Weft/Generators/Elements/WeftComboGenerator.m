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

static NSString * const kComboElementName = @"combo";

@implementation WeftComboGenerator

- (NSString *)elementName {
  return kComboElementName;
}

- (BOOL)requiresId {
  return YES;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSArray *choices = [self choices:attributes];
  NSComboBox *combo = [[NSComboBox alloc] init];
  combo.translatesAutoresizingMaskIntoConstraints = NO;
  combo.weftElementId = elementId;
  combo.weftAttributes = attributes;
  combo.completes = YES;
  [combo addItemsWithObjectValues:choices];

  attr = [attributes stringAttribute:kDefaultAttributeName];
  if( attr.defined ) {
    [combo selectItemWithObjectValue:attr.stringValue];
  }

  [self addView:combo];
  [self.app registerElement:combo];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:[combo stringValue] forKey:elementId];
  }];
}

- (void)closeElementText:(NSString *)text {
}

@end
