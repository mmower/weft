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

static NSString * const kRadioElementName = @"radio";

@implementation WeftRadioGenerator

- (NSString *)elementName {
  return kRadioElementName;
}

/*
 * There is an issue here that we have radio buttons defined without an id although they
 * are controls. Of course the issue is that it doesn't make sense to have a series of
 * buttons with the same ID and there is no "Radio" control to which we can add the id.
 */
- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:kIdAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Config Error"
                                   reason:@"<radio> defined without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSString *defaultValue;
  attr = [attributes stringAttribute:kDefaultAttributeName];
  if( attr.defined ) {
    defaultValue = attr.stringValue;
  }

  NSArray *choices = [self choices:attributes];

  NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:choices.count];
  for( NSString *choice in choices ) {
    NSButton *button = [NSButton radioButtonWithTitle:choice
                                               target:self.app
                                               action:@selector(radioSelected:)];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.weftAttributes = attributes;
    [self addView:button];
    if( [choice isEqualToString:defaultValue] ) {
      [button setState:NSControlStateValueOn];
    }
    [buttons addObject:button];
  }

  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    for( NSButton *button in buttons ) {
      if( button.state == NSControlStateValueOn ) {
        [values setObject:button.title forKey:elementId];
      }
    }
  }];
}

- (void)closeElementText:(NSString *)text {
}

@end
