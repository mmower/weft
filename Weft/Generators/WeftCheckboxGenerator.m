//
//  WeftCheckboxGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftCheckboxGenerator.h"

#import "WeftApplication.h"

#import "NSDictionary+Weft.h"

@implementation WeftCheckboxGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"checkbox"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *title = @"";
  attr = [attributes stringAttribute:@"title"];
  if( attr.defined ) {
    title = attr.stringValue;
  }

  NSButton *button = [NSButton checkboxWithTitle:title
                                          target:nil
                                          action:nil];
  attr = [attributes boolAttribute:@"disabled"];
  if( attr.defined ) {
    button.enabled = !attr.boolValue;
  }

  [app addArrangedSubview:button];
  [app registerElement:button attributes:attributes];
}

- (void)closeElementApp:(WeftApplication *)app {
}

@end
