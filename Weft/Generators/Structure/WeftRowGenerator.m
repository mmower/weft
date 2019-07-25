//
//  WeftRowGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftRowGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

NSString * const kRowElementName = @"row";

@implementation WeftRowGenerator

- (NSString *)elementName {
  return kRowElementName;
}

- (BOOL)requiresId {
  return NO;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes  {
  NSStackView *stackView = [self createStackWithOrientation:NSUserInterfaceLayoutOrientationHorizontal
                                                 attributes:attributes];
  stackView.weftElementId = elementId;

  [self addView:stackView];

  [self.app pushStack:stackView];
}

- (void)closeElementText:(NSString *)text {
  [self.app popStack];
}

@end
