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

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:kIdAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Date Error"
                                   reason:@"<date> without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  NSDatePicker *datePicker = [[NSDatePicker alloc] init];
  datePicker.weftAttributes = attributes;
  datePicker.translatesAutoresizingMaskIntoConstraints = NO;
  datePicker.weftAttributes = attributes;
  datePicker.elementId = elementId;

  NSString *dateFormat = @"EE, d LLL yyyy HH:mm:ss Z";
  if( attr.defined ) {
    dateFormat = attr.stringValue;
  }

  attr = [attributes dateAttribute:kDateAttributeName format:dateFormat];
  if( !attr.defined ) {
    datePicker.dateValue = [NSDate date];
  } else {
    datePicker.dateValue = attr.dateValue;
  }

  [self addView:datePicker];
  [self.app registerElement:datePicker];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:datePicker.dateValue forKey:elementId];
  }];
}

- (void)closeElementText:(NSString *)foundChars {
}

@end
