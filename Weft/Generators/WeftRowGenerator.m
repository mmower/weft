//
//  WeftRowGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftRowGenerator.h"

#import "NSDictionary+Weft.h"

@implementation WeftRowGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"row"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  NSParameterAssert(app);
  NSParameterAssert(attributes);

  NSStackView *stackView = [[NSStackView alloc] init];
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  stackView.orientation = NSUserInterfaceLayoutOrientationHorizontal;

  WeftAttribute *attr = [attributes insetsAttribute:@"insets"];
  if( attr.defined ) {
    stackView.edgeInsets = attr.insetsValue;
  }

  [app addArrangedSubview:stackView];
  [app pushStack:stackView];
}

- (void)closeElementApp:(WeftApplication *)app {
  [app popStack];
}

@end
