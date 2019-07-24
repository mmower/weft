//
//  WeftButtonGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftButtonGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftButtonGenerator

- (NSString *)elementName {
  return @"button";
}

- (void)button:(NSButton *)button shouldBeDisabled:(NSDictionary *)attributes {
  WeftAttribute *attr = [attributes boolAttribute:kDisabledAttributeName];
  if( attr.defined ) {
    [button setEnabled:!attr.boolValue];
  }
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:kIdAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"Button without id"
                                 userInfo:nil];
  }
  NSString *elementId = attr.stringValue;

  attr = [attributes stringAttribute:kTitleAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"Button without title"
                                 userInfo:nil];
  }
  NSString *title = attr.stringValue;

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:self.app
                                        action:@selector(buttonPushed:)];
  button.weftAttributes = attributes;
  button.translatesAutoresizingMaskIntoConstraints = NO;

  [button setElementId:elementId];

  [self view:button shouldHaveTooltip:attributes];
  [self button:button shouldBeDisabled:attributes];

  [self addView:button];
  [self.app registerElement:button];
}

- (void)closeElementText:(NSString *)foundChars {
}

@end
