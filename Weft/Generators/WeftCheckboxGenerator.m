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

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"checkbox"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Checkbox Error"
                                   reason:@"Checkbox without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSString *title = @"";
  attr = [attributes stringAttribute:@"title"];
  if( attr.defined ) {
    title = attr.stringValue;
  }

  NSButton *button = [NSButton checkboxWithTitle:title
                                          target:nil
                                          action:nil];
  [button setElementId:elementId];
  attr = [attributes boolAttribute:@"disabled"];
  if( attr.defined ) {
    button.enabled = !attr.boolValue;
  }

  [app addArrangedSubview:button];
  [app registerElement:button attributes:attributes];
  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:@([button state] == NSControlStateValueOn) forKey:elementId];
  }];
}

- (void)closeElementApp:(WeftApplication *)app {
}

@end
