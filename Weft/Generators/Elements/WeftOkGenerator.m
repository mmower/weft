//
//  WeftOkGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftOkGenerator.h"

#import "NSDictionary+Weft.h"

@implementation WeftOkGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"ok"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *title = @"Ok";
  attr = [attributes stringAttribute:@"title"];
  if( attr.defined ) {
    title = attr.stringValue;
  }

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:app
                                        action:@selector(pressedOk:)];
  button.translatesAutoresizingMaskIntoConstraints = NO;

  [self app:app addView:button gravity:[attributes gravityAttribute:@"gravity"]];

  app.hasOk = YES;
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
}

@end
