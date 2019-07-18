//
//  WeftColGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftColGenerator.h"

#import "NSDictionary+Weft.h"

@implementation WeftColGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"col"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  NSParameterAssert(app);
  NSParameterAssert(attributes);

  NSStackView *stackView = [[NSStackView alloc] init];
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  stackView.orientation = NSUserInterfaceLayoutOrientationVertical;

  WeftAttribute *attr = [attributes insetsAttribute:@"insets"];
  if( attr.defined ) {
    stackView.edgeInsets = attr.insetsValue;
  }

  [self app:app addView:stackView gravity:[attributes gravityAttribute:@"gravity"]];
  
  [app pushStack:stackView];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
  [app popStack];
}

@end
