//
//  WeftPopupbuttonGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftPopupbuttonGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

static NSString * const kPopupElementName = @"popupbutton";

@implementation WeftPopupbuttonGenerator

- (NSString *)elementName {
  return kPopupElementName;
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:kIdAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Configuration error"
                                   reason:@"Popup defined without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSArray *choices;
  attr = [attributes csvAttribute:kChoicesAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Configuration error"
                                   reason:@"Popup defined without 'choices' attribute"
                                 userInfo:attributes];
  } else {
    choices = attr.csvValue;
  }

  NSPopUpButton *popup = [[NSPopUpButton alloc] init];
  popup.translatesAutoresizingMaskIntoConstraints = NO;
  popup.weftAttributes = attributes;
  [popup addItemsWithTitles:choices];

  attr = [attributes stringAttribute:kDefaultAttributeName];
  if( attr.defined ) {
    [popup selectItemWithTitle:attr.stringValue];
  }

  [self addView:popup];
  [self.app registerElement:popup];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:[popup titleOfSelectedItem] forKey:elementId];
  }];
}

- (void)closeElementText:(NSString *)text {
}

@end
