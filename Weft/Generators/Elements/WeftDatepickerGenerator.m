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

static NSString * const kDatepickerElementName = @"datepicker";

@implementation WeftDatepickerGenerator

- (NSString *)elementName {
  return kDatepickerElementName;
}

- (BOOL)requiresId {
  return YES;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSDatePicker *datePicker = [[NSDatePicker alloc] init];
  datePicker.weftElementId = elementId;
  datePicker.weftAttributes = attributes;
  datePicker.translatesAutoresizingMaskIntoConstraints = NO;

  NSString *dateFormat;
  if( attr.defined ) {
    dateFormat = attr.stringValue;
  } else {
    dateFormat = @"EE, d LLL yyyy HH:mm:ss Z";
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

- (void)closeElementText:(NSString *)text {
}

@end
