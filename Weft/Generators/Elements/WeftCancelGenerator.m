//
//  WeftCancelGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftCancelGenerator.h"

#import "WeftApplication.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftCancelGenerator

- (NSString *)elementName {
  return @"cancel";
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *title = @"Cancel";
  attr = [attributes stringAttribute:kTitleAttributeName];
  if( attr.defined ) {
    title = attr.stringValue;
  }

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:self.app
                                        action:@selector(pressedCancel:)];
  button.translatesAutoresizingMaskIntoConstraints = NO;
  button.weftAttributes = attributes;
  [self addView:button];
}

- (void)closeElementText:(NSString *)foundChars {
}

@end
