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

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:kIdAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"WeftParserException"
                                   reason:@"TextField without id"
                                 userInfo:nil];
  }
  NSString *elementId = attr.stringValue;

  NSTextField *textField = [[NSTextField alloc] init];
  textField.translatesAutoresizingMaskIntoConstraints = NO;
  [textField setElementId:elementId];

  attr = [attributes stringAttribute:kDefaultAttributeName];
  if( attr.defined ) {
    textField.stringValue = attr.stringValue;
  }

  attr = [attributes stringAttribute:kPlaceholderAtributeName];
  if( attr.defined ) {
    [textField setPlaceholderString:attr.stringValue];
  }

  attr = [attributes stringAttribute:kTooltipAttributeName];
  if( attr.defined ) {
    [textField setToolTip:attr.stringValue];
  }

  attr = [attributes boolAttribute:kDisabledAttributeName];
  if( attr.defined && attr.boolValue ) {
    [textField setEnabled:NO];
  }

  [self addView:textField];

  attr = [attributes floatAttribute:kWidthAttributeName];
  if( attr.defined ) {
    [textField pinWidth:attr.floatValue];
  }

  attr = [attributes floatAttribute:kHeightAttributeName];
  if( attr.defined ) {
    [textField pinHeight:attr.floatValue];
  }

  [self.app registerElement:textField];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:textField.stringValue forKey:elementId];    
  }];
}

- (void)closeElementText:(NSString *)text {
}

@end
