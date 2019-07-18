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

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"title"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Label Error"
                                   reason:@"Label without 'id' attribute"
                                 userInfo:attributes];
  }

  NSTextField *label = [NSTextField labelWithString:attr.stringValue];

  attr = [attributes gravityAttribute:@"gravity"];
  if( attr.defined ) {
    [app addView:label inGravity:attr.gravityValue];
  } else {
    [app addArrangedSubview:label];
  }
}

- (void)closeElementApp:(WeftApplication *)app {

}

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"label"];
}

@end
