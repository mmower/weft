//
//  WeftCheckboxGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftCheckboxGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftCheckboxGenerator

- (NSString *)elementName {
  return @"checkbox";
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:kIdAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Checkbox Error"
                                   reason:@"Checkbox without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSString *title = @"";
  attr = [attributes stringAttribute:kTitleAttributeName];
  if( attr.defined ) {
    title = attr.stringValue;
  }

  NSButton *button = [NSButton checkboxWithTitle:title
                                          target:nil
                                          action:nil];
  button.elementId = elementId;
  button.weftAttributes = attributes;
  attr = [attributes boolAttribute:kDisabledAttributeName];
  if( attr.defined ) {
    button.enabled = !attr.boolValue;
  }

  [self addView:button];
  
  [self.app registerElement:button];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:@([button state] == NSControlStateValueOn) forKey:elementId];
  }];
}

- (void)closeElementText:(NSString *)foundChars {
}

@end
