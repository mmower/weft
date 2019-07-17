//
//  WeftWindowGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftWindowGenerator.h"

#import "WeftApplication.h"

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
  app.currentStack.translatesAutoresizingMaskIntoConstraints = NO;
  app.currentStack.orientation = NSUserInterfaceLayoutOrientationVertical;

  [app.appView addSubview:app.currentStack];
}

- (void)closeElementApp:(WeftApplication *)app {
}

@end
