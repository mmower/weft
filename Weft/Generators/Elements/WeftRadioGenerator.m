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

- (BOOL)requiresId {
  return YES;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *defaultValue;
  attr = [attributes stringAttribute:kDefaultAttributeName];
  if( attr.defined ) {
    defaultValue = attr.stringValue;
  }

  NSArray *choices = [self choices:attributes];

  NSStackView *elementView = [self createStackWithOrientation:NSUserInterfaceLayoutOrientationHorizontal attributes:attributes];
  elementView.weftElementId = elementId;

  NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:choices.count];
  for( NSString *choice in choices ) {
    NSButton *button = [NSButton radioButtonWithTitle:choice
                                               target:self.app
                                               action:@selector(radioSelected:)];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [elementView addArrangedSubview:button];

    if( [choice isEqualToString:defaultValue] ) {
      [button setState:NSControlStateValueOn];
    }

    [buttons addObject:button];
  }

  [self addView:elementView];

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
