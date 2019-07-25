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

static NSString * const kLabelElementName = @"label";

@implementation WeftLabelGenerator

- (NSString *)elementName {
  return kLabelElementName;
}

- (BOOL)requiresId {
  return NO;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:kTitleAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Config Error"
                                   reason:@"<label> element requires the 'title' attribute"
                                 userInfo:attributes];
  }

  NSTextField *label = [NSTextField labelWithString:attr.stringValue];
  label.weftElementId = elementId;
  label.weftAttributes = attributes;


  [self addView:label];
  [self.app registerElement:label];

  attr = [attributes stringAttribute:@"same-width"];
  if( attr.defined ) {
    [self.app deferConstraint:^{
      NSView *item = [self.app elementWithId:attr.stringValue];
      if( !item ) {
        @throw [NSException exceptionWithName:@"Layout Error"
                                       reason:[NSString stringWithFormat:@"Unable to find an item with id: %@",attr.stringValue]
                                     userInfo:nil];
      }
      [[label ancestorSharedWithView:item] addConstraint:[NSLayoutConstraint constraintWithItem:label
                                                                                      attribute:NSLayoutAttributeWidth
                                                                                      relatedBy:NSLayoutRelationEqual
                                                                                         toItem:item
                                                                                      attribute:NSLayoutAttributeWidth
                                                                                     multiplier:1.0
                                                                                       constant:0.0]];
    }];
  }
}

- (void)closeElementText:(NSString *)text {
}

@end
