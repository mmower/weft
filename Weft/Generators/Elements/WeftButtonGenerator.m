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

static NSString * const kButtonElementName = @"button";

@implementation WeftButtonGenerator

- (NSString *)elementName {
  return kButtonElementName;
}

- (BOOL)requiresId {
  return NO;
}

- (void)button:(NSButton *)button shouldBeDisabled:(NSDictionary *)attributes {
  WeftAttribute *attr = [attributes boolAttribute:kDisabledAttributeName];
  if( attr.defined ) {
    [button setEnabled:!attr.boolValue];
  }
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

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
  button.weftElementId = elementId;
  button.weftAttributes = attributes;

  [self view:button shouldHaveTooltip:attributes];
  [self button:button shouldBeDisabled:attributes];

  button.translatesAutoresizingMaskIntoConstraints = NO;
  [self addView:button];
  [self.app registerElement:button];
}

- (void)closeElementText:(NSString *)text {
}

@end
