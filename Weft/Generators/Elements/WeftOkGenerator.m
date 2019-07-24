//
//  WeftOkGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftOkGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftOkGenerator

- (NSString *)elementName {
  return @"ok";
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *title = @"Ok";
  attr = [attributes stringAttribute:@"title"];
  if( attr.defined ) {
    title = attr.stringValue;
  }

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:self.app
                                        action:@selector(pressedOk:)];
  button.translatesAutoresizingMaskIntoConstraints = NO;
  button.weftAttributes = attributes;
  [self addView:button];

  self.app.hasOk = YES;
}

- (void)closeElementText:(NSString *)foundChars {
}

@end
