//
//  WeftTextfieldGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftTextfieldGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

const NSInteger kTextFieldHeight = 22;
const NSInteger kTextFieldDefaultWidth = 280;

@implementation WeftTextfieldGenerator

- (NSString *)elementName {
  return @"textfield";
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  NSParameterAssert(app);
  NSParameterAssert(attributes);

  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"TextField without id"
                                 userInfo:nil];
  }
  NSString *elementId = attr.stringValue;

//  attr = [attributes stringAttribute:@"label"];
//  if( attr.defined ) {
//    NSTextField *label = [NSTextField labelWithString:attr.stringValue];
//    [app addArrangedSubview:label];
//  }

  NSTextField *textField = [[NSTextField alloc] init];
  textField.translatesAutoresizingMaskIntoConstraints = NO;
  [textField setElementId:elementId];

  attr = [attributes stringAttribute:@"placeholder"];
  if( attr.defined ) {
    [textField setPlaceholderString:attr.stringValue];
  }

  attr = [attributes stringAttribute:@"tooltip"];
  if( attr.defined ) {
    [textField setToolTip:attr.stringValue];
  }

  attr = [attributes boolAttribute:@"disabled"];
  if( attr.defined && attr.boolValue ) {
    [textField setEnabled:NO];
  }

  [self app:app addView:textField gravity:[attributes gravityAttribute:@"gravity"]];
  [self app:app autoPinWidthOfView:textField attributes:attributes];
  [self app:app autoPinHeightOfView:textField attributes:attributes];

  [app registerElement:textField attributes:attributes];
  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:textField.stringValue forKey:elementId];    
  }];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
}

@end
