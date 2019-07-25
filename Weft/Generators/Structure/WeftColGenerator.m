//
//  WeftColGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftColGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

static NSString * const kColElementName = @"col";

@implementation WeftColGenerator

- (NSString *)elementName {
  return kColElementName;
}

- (BOOL)requiresId {
  return NO;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  NSStackView *stackView = [super createStackWithOrientation:NSUserInterfaceLayoutOrientationVertical
                                                  attributes:attributes];
  stackView.weftElementId = elementId;
  stackView.weftAttributes = attributes;

  [self addView:stackView];

  [self.app pushStack:stackView];
}

- (void)closeElementText:(NSString *)text {
  [self.app popStack];
}

@end
