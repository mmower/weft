//
//  WeftLabelGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftLabelGenerator.h"

#import "NSDictionary+Weft.h"

@implementation WeftLabelGenerator

- (NSString *)elementName {
  return @"label";
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"title"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Label Error"
                                   reason:@"Label without 'id' attribute"
                                 userInfo:attributes];
  }

  NSTextField *label = [NSTextField labelWithString:attr.stringValue];

  [self app:app addView:label gravity:[attributes gravityAttribute:@"gravity"]];
  [self app:app autoPinWidthOfView:label attributes:attributes];
  [self app:app autoPinHeightOfView:label attributes:attributes];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {

}

@end
