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

@implementation WeftWindowGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"window"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  NSParameterAssert(app);
  NSParameterAssert(attributes);

  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"title"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Window Definition Error"
                                   reason:@"Window without 'title' attribute"
                                 userInfo:@{}];
  } else {
    app.title = attr.stringValue;
  }
  NSLog( @"app.title -> %@", app.title );

  attr = [attributes integerAttribute:@"width"];
  if( attr.defined ) {
    app.width = attr.integerValue;
  } else {
    app.width = kDefaultApplicationWidth;
  }

  attr = [attributes integerAttribute:@"height"];
  if( attr.defined ) {
    app.height = attr.integerValue;
  } else {
    app.height = kDefaultApplicationHeight;
  }

  app.appView = [[WeftFlippedView alloc] initWithFrame:NSMakeRect(0, 0, app.width, app.height)];

  app.currentStack = [[NSStackView alloc] initWithFrame:NSMakeRect(0, 0, app.width, app.height)];
  app.currentStack.orientation = NSUserInterfaceLayoutOrientationVertical;
  app.currentStack.translatesAutoresizingMaskIntoConstraints = NO;
  [app.appView addSubview:app.currentStack];

  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:app.currentStack
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:app.appView
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:0.0]];
  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:app.currentStack
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:app.appView
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:0.0]];
  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:app.currentStack
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:app.appView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:0.0]];
  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:app.currentStack
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:app.appView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0.0]];

}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
}

@end
