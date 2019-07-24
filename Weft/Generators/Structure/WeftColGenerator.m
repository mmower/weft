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

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:kColElementName];
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  NSStackView *stackView = [super createStackWithOrientation:NSUserInterfaceLayoutOrientationVertical
                                                  attributes:attributes];
  [self addView:stackView];
  [self.app pushStack:stackView];
}

- (void)closeElementText:(NSString *)text {
  [self.app popStack];
}

@end
