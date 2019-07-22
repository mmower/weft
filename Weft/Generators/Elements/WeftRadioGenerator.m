//
//  WeftRadioGenerator.m
//  Weft
//
//  Created by Matthew Mower on 21/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftRadioGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftRadioGenerator

- (NSString *)elementName {
  return @"radio";
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Config Error"
                                   reason:@"<radio> defined without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSArray *choices;
  attr = [attributes csvAttribute:@"choices"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Config Error"
                                   reason:@"<radio> defined without 'choices' attribute"
                                 userInfo:attributes];
  } else {
    choices = attr.csvValue;
  }

  NSString *defaultValue;
  attr = [attributes stringAttribute:@"default"];
  if( attr.defined ) {
    defaultValue = attr.stringValue;
  }

  NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:choices.count];
  for( NSString *choice in choices ) {
    NSButton *button = [NSButton radioButtonWithTitle:choice target:app action:@selector(radioSelected:)];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self app:app addView:button gravity:[attributes gravityAttribute:@"gravity"]];
    if( [choice isEqualToString:defaultValue] ) {
      [button setState:NSControlStateValueOn];
    }
    [buttons addObject:button];
  }

  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    for( NSButton *button in buttons ) {
      if( button.state == NSControlStateValueOn ) {
        [values setObject:button.title forKey:elementId];
      }
    }
  }];

}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {

}

@end
