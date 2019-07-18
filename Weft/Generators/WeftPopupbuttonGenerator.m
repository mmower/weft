//
//  WeftPopupbuttonGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftPopupbuttonGenerator.h"

#import "NSDictionary+Weft.h"

@implementation WeftPopupbuttonGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"popupbutton"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Popup error"
                                   reason:@"Popup defined without 'id' attribute"
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

  NSPopUpButton *popup = [[NSPopUpButton alloc] init];
  popup.translatesAutoresizingMaskIntoConstraints = NO;
  [popup addItemsWithTitles:choices];

  attr = [attributes stringAttribute:@"default"];
  if( attr.defined ) {
    [popup selectItemWithTitle:attr.stringValue];
  }

  attr = [attributes gravityAttribute:@"gravity"];
  if( attr.defined ) {
    [app addView:popup inGravity:attr.gravityValue];
  } else {
    [app addArrangedSubview:popup];
  }

  [app registerElement:popup attributes:attributes];
  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:[popup titleOfSelectedItem] forKey:elementId];
  }];
}

- (void)closeElementApp:(WeftApplication *)app {

}

@end
