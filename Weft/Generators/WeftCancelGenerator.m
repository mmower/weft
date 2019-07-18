//
//  WeftCancelGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftCancelGenerator.h"

#import "NSDictionary+Weft.h"

@implementation WeftCancelGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"cancel"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *title = @"Cancel";
  attr = [attributes stringAttribute:@"title"];
  if( attr.defined ) {
    title = attr.stringValue;
  }

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:app
                                        action:@selector(pressedCancel:)];

  attr = [attributes gravityAttribute:@"gravity"];
  if( attr.defined ) {
    [app addView:button inGravity:attr.gravityValue];
  } else {
    [app addArrangedSubview:button];
  }

}

- (void)closeElementApp:(WeftApplication *)app {
}

@end
