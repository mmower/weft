//
//  WeftWindowGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftWindowGenerator.h"

#import "WeftFlippedView.h"

#import "NSDictionary+Weft.h"

static NSString * const kWindowElementName = @"window";

@implementation WeftWindowGenerator

- (NSString *)elementName {
  return kWindowElementName;
}

- (void)openElementAttributes:(NSDictionary *)attributes {
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
  self.app.currentStack = [[NSStackView alloc] initWithFrame:NSMakeRect(0, 0, self.app.width, self.app.height)];
  self.app.currentStack.orientation = NSUserInterfaceLayoutOrientationVertical;
  self.app.currentStack.translatesAutoresizingMaskIntoConstraints = NO;
  [self.app.appView addSubview:self.app.currentStack];

  [self.app.appView addConstraint:[NSLayoutConstraint constraintWithItem:self.app.currentStack
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.app.appView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:0.0]];
  [self.app.appView addConstraint:[NSLayoutConstraint constraintWithItem:self.app.currentStack
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.app.appView
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:0.0]];
  [self.app.appView addConstraint:[NSLayoutConstraint constraintWithItem:self.app.currentStack
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.app.appView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:0.0]];
  [self.app.appView addConstraint:[NSLayoutConstraint constraintWithItem:self.app.currentStack
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.app.appView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0.0]];

}

- (void)closeElementText:(NSString *)text {
}

@end
