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

static NSString * const kCancelElementName = @"cancel";

@implementation WeftCancelGenerator

- (NSString *)elementName {
  return kCancelElementName;
}

- (BOOL)requiresId {
  return NO;
}

- (void)openElementId:(nullable NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *title;
  attr = [attributes stringAttribute:kTitleAttributeName];
  if( attr.defined ) {
    title = attr.stringValue;
  } else {
    title = @"Cancel";
  }

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:self.app
                                        action:@selector(pressedCancel:)];
  button.weftElementId = elementId;
  button.weftAttributes = attributes;

  button.translatesAutoresizingMaskIntoConstraints = NO;
  [self addView:button];
}

- (void)closeElementText:(NSString *)text {
}

@end
