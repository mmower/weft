//
//  WeftComboGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftComboGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftComboGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"combo"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Combo error"
                                   reason:@"Combo defined without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSArray *choices;
  attr = [attributes csvAttribute:@"choices"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Popup error"
                                   reason:@"Popup defined without 'choices' attribute"
                                 userInfo:attributes];
  } else {
    choices = attr.csvValue;
  }

  NSComboBox *combo = [[NSComboBox alloc] init];
  combo.translatesAutoresizingMaskIntoConstraints = NO;
  combo.completes = YES;
  [combo addItemsWithObjectValues:choices];

  attr = [attributes stringAttribute:@"default"];
  if( attr.defined ) {
    [combo selectItemWithObjectValue:attr.stringValue];
  }

  attr = [attributes gravityAttribute:@"gravity"];
  if( attr.defined ) {
    [app addView:combo inGravity:attr.gravityValue];
  } else {
    [app addArrangedSubview:combo];
  }

  attr = [attributes integerAttribute:@"width"];
  if( attr.defined ) {
    [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:combo
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:attr.integerValue]];
  }

  attr = [attributes integerAttribute:@"height"];
  if( attr.defined ) {
    [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:combo
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:attr.integerValue]];
  }

  [app registerElement:combo attributes:attributes];
  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:[combo objectValueOfSelectedItem] forKey:elementId];
  }];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
}


@end
