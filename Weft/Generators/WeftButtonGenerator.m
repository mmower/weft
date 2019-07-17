//
//  WeftButtonGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftButtonGenerator.h"

#import "WeftApplication.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftButtonGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"button"];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  NSParameterAssert(app);
  NSParameterAssert(attributes);

  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"Button without id"
                                 userInfo:nil];
  }
  NSString *elementId = attr.stringValue;

  attr = [attributes stringAttribute:@"title"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"Button without title"
                                 userInfo:nil];
  }
  NSString *title = attr.stringValue;

  NSButton *button = [NSButton buttonWithTitle:title
                                        target:app
                                        action:@selector(buttonPushed:)];
  button.translatesAutoresizingMaskIntoConstraints = NO;

  [button setElementId:elementId];

  attr = [attributes stringAttribute:@"tooltip"];
  if( attr.defined ) {
    [button setToolTip:attr.stringValue];
  }

  attr = [attributes boolAttribute:@"disabled"];
  if( attr.defined && attr.boolValue ) {
    [button setEnabled:NO];
  }

  attr = [attributes gravityAttribute:@"gravity"];
  if( !attr.defined ) {
    [app addArrangedSubview:button];
  } else {
    [app addView:button inGravity:attr.gravityValue];
  }

  [app registerElement:button attributes:attributes];
}

- (void)closeElementApp:(WeftApplication *)app {
  
}

@end
