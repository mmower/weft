//
//  WeftDatepickerGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftDatepickerGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftDatepickerGenerator

- (NSString *)elementName {
  return @"datepicker";
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:@"id"];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Date Error"
                                   reason:@"<date> without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSDatePicker *datePicker = [[NSDatePicker alloc] init];
  datePicker.translatesAutoresizingMaskIntoConstraints = NO;
  datePicker.elementId = elementId;

  NSString *dateFormat = @"EE, d LLL yyyy HH:mm:ss Z";
  if( attr.defined ) {
    dateFormat = attr.stringValue;
  }

  attr = [attributes dateAttribute:@"date" format:dateFormat];
  if( !attr.defined ) {
    datePicker.dateValue = [NSDate date];
  } else {
    datePicker.dateValue = attr.dateValue;
  }

  [self app:app addView:datePicker gravity:[attributes gravityAttribute:@"gravity"]];

  [app registerElement:datePicker attributes:attributes];
  [app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:datePicker.dateValue forKey:elementId];
  }];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
}

@end
