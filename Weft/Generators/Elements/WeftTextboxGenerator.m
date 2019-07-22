//
//  WeftTextboxGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftTextboxGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftTextboxGenerator

- (NSString *)elementName {
  return @"textbox";
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Textbox Error"
                                   reason:@"<textbox> without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  self.textView = [[NSTextView alloc] init];
  self.textView.translatesAutoresizingMaskIntoConstraints = NO;

  [self app:app addView:self.textView gravity:[attributes gravityAttribute:@"gravity"]];
  [self app:app autoPinWidthOfView:self.textView attributes:attributes];
  [self app:app autoPinHeightOfView:self.textView attributes:attributes];

  [app registerElement:self.textView attributes:attributes];
  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:self.textView.string forKey:elementId];
  }];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
  self.textView.string = foundChars;
}

@end
