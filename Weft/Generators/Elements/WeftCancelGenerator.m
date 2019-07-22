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

- (NSString *)elementName {
  return @"cancel";
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

  [self app:app addView:button gravity:[attributes gravityAttribute:@"gravity"]];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
}

@end
