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

- (BOOL)requiresId {
  return YES;
}

- (void)openElementId:(NSString *)elementId attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes boolAttribute:kScrollableAttributeName];
  BOOL scrollable = attr.defined && attr.boolValue;

  self.textView = [[NSTextView alloc] init];
  self.textView.weftElementId = elementId;
  self.textView.weftAttributes = attributes;
  if( !scrollable ) {
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
  } else {
    self.textView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
  }

  attr = [attributes boolAttribute:kEditableAttributeName];
  if( attr.defined ) {
    self.textView.editable = attr.boolValue;
  }

  attr = [attributes boolAttribute:kSelectableAttributeName];
  if( attr.defined ) {
    self.textView.selectable = attr.boolValue;
  }

  NSView *view;
  attr = [attributes boolAttribute:kScrollableAttributeName];
  if( scrollable ) {
    NSScrollView *scrollView = [[NSScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.hasHorizontalScroller = YES;
    scrollView.hasVerticalScroller = YES;
    [scrollView setDocumentView:self.textView];
    view = scrollView;

    [self.textView setVerticallyResizable:YES];
    [self.textView setHorizontallyResizable:YES];
//    [self.textView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
//    [[self.textView textContainer] setWidthTracksTextView:YES];
//    [self.textView pinEdgesToSuperviewEdges];
  } else {
    view = self.textView;
  }

  [self addView:view];
  [self.app registerElement:self.textView];
  [self.app registerExtractor:^(NSMutableDictionary * _Nonnull values) {
    [values setObject:self.textView.string forKey:elementId];
  }];
}

- (void)closeElementText:(NSString *)text {
  self.textView.string = text;
}

@end
