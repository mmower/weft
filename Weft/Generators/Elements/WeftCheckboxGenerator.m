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

static NSString *kCheckboxElementName = @"checkbox";

@implementation WeftCheckboxGenerator

- (NSString *)elementName {
  return kCheckboxElementName;
}

- (BOOL)requiresId {
  return YES;
}

- (void)openElementId:(nullable NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *title;
  attr = [attributes stringAttribute:kTitleAttributeName];
  if( attr.defined ) {
    title = attr.stringValue;
  } else {
    title = @"";
  }

  NSButton *button = [NSButton checkboxWithTitle:title
                                          target:self.app
                                          action:@selector(checkboxToggled:)];
  button.weftElementId = elementId;
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

- (void)closeElementText:(NSString *)text {
}

@end
