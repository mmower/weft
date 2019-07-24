//
//  WeftTextboxGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftTextboxGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

static NSString * const kTextboxElementName = @"textbox";

@implementation WeftTextboxGenerator

- (NSString *)elementName {
  return kTextboxElementName;
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSString *elementId;
  attr = [attributes stringAttribute:kIdAttributeName];
  if( !attr.defined ) {
    @throw [NSException exceptionWithName:@"Textbox Error"
                                   reason:@"<textbox> without 'id' attribute"
                                 userInfo:attributes];
  } else {
    elementId = attr.stringValue;
  }

  self.textView = [[NSTextView alloc] init];
  self.textView.translatesAutoresizingMaskIntoConstraints = NO;
  self.textView.weftAttributes = attributes;

  NSView *view;
  attr = [attributes boolAttribute:kScrollableAttributeName];
  if( attr.defined ) {
    if( attr.boolValue ) {
      NSScrollView *scrollView = [[NSScrollView alloc] init];
      scrollView.translatesAutoresizingMaskIntoConstraints = NO;
      scrollView.documentView = self.textView;
      scrollView.hasHorizontalScroller = YES;
      scrollView.hasVerticalScroller = YES;
      view = scrollView;

      [_textView pinEdgeToSuperviewEdge:NSLayoutAttributeLeading];
      [_textView pinEdgeToSuperviewEdge:NSLayoutAttributeTop];
      [_textView pinEdgeToSuperviewEdge:NSLayoutAttributeTrailing];
      [_textView pinEdgeToSuperviewEdge:NSLayoutAttributeBottom];
    } else {
      view = self.textView;
    }
  }

  attr = [attributes boolAttribute:kEditableAttributeName];
  if( attr.defined ) {
    self.textView.editable = attr.boolValue;
  }

  attr = [attributes boolAttribute:kSelectableAttributeName];
  if( attr.defined ) {
    self.textView.selectable = attr.boolValue;
  }

  [self addView:view];

//  [self app:app autoPinWidthOfView:view attributes:attributes];
//  [self app:app autoPinHeightOfView:view attributes:attributes];

  [self.app registerElement:self.textView];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:self.textView.string forKey:elementId];
  }];
}

- (void)closeElementText:(NSString *)text {
  self.textView.string = text;
}

@end
