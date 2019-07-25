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

static NSString * const kOkElementName = @"ok";

@implementation WeftOkGenerator

- (NSString *)elementName {
  return kOkElementName;
}

- (BOOL)requiresId {
  return NO;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *title;
  attr = [attributes stringAttribute:kTitleAttributeName];
  if( attr.defined ) {
    title = attr.stringValue;
  } else {
    title = @"Ok";
  }

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:self.app
                                        action:@selector(pressedOk:)];
  button.weftElementId = elementId;
  button.weftAttributes = attributes;

  button.translatesAutoresizingMaskIntoConstraints = NO;
  [self addView:button];

  self.app.hasOk = YES;
}

- (void)closeElementText:(NSString *)text {
}

@end
