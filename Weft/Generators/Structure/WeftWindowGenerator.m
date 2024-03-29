//
//  WeftWindowGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftWindowGenerator.h"

#import "WeftFlippedView.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

static NSString * const kWindowElementName = @"window";

@implementation WeftWindowGenerator

- (NSString *)elementName {
  return kWindowElementName;
}

- (BOOL)requiresId {
  return NO;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:kTitleAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Window Definition Error"
                                   reason:@"Window without 'title' attribute"
                                 userInfo:@{}];
  } else {
    self.app.title = attr.stringValue;
  }

  attr = [attributes integerAttribute:kWidthAttributeName];
  if( attr.defined ) {
    self.app.width = attr.integerValue;
  } else {
    self.app.width = kDefaultApplicationWidth;
  }

  attr = [attributes integerAttribute:kHeightAttributeName];
  if( attr.defined ) {
    self.app.height = attr.integerValue;
  } else {
    self.app.height = kDefaultApplicationHeight;
  }

  self.app.appView = [[WeftFlippedView alloc] initWithFrame:NSMakeRect(0, 0, self.app.width, self.app.height)];

  NSStackView *stack = [self createStackWithOrientation:NSUserInterfaceLayoutOrientationVertical
                                             attributes:attributes];

  self.app.currentStack = stack;
  [self.app.appView addSubview:self.app.currentStack];

  [[self currentStack] pinEdgesToSuperviewEdges];
}

- (void)closeElementText:(NSString *)text {
}

@end
