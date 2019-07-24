//
//  WeftLabelGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftLabelGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftLabelGenerator

- (NSString *)elementName {
  return @"label";
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"title"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Label Error"
                                   reason:@"Label without 'id' attribute"
                                 userInfo:attributes];
  }

  NSTextField *label = [NSTextField labelWithString:attr.stringValue];
  label.weftAttributes = attributes;

  [self addView:label];
//  [self app:app autoPinWidthOfView:label attributes:attributes];
//  [self app:app autoPinHeightOfView:label attributes:attributes];
}

- (void)closeElementText:(NSString *)foundChars {
}

@end
