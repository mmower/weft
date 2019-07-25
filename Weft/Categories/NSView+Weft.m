//
//  NSView+Weft.m
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <objc/runtime.h>

#import "NSView+Weft.h"

@implementation NSView (Weft)

#pragma mark -
#pragma mark Dynamic properties

@dynamic weftElementId;

- (NSString *)weftElementId {
  return (NSString *)objc_getAssociatedObject( self, @selector(weftElementId) );
}

- (void)setWeftElementId:(NSString *)elementId {
  objc_setAssociatedObject( self, @selector(weftElementId), elementId, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

@dynamic weftAttributes;

- (NSDictionary *)weftAttributes {
  return (NSDictionary *)objc_getAssociatedObject( self, @selector(weftAttributes) );
}

- (void)setWeftAttributes:(NSDictionary *)weftAttributes {
  objc_setAssociatedObject( self, @selector(weftAttributes), weftAttributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

#pragma mark -
#pragma mark AutoLayout Helpers

- (void)pinWidth:(CGFloat)width {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                   attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                    constant:width]];
}

- (void)pinHeight:(CGFloat)height {
  [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                   attribute:NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1.0
                                                    constant:height]];
}

- (void)pinEdgeToSuperviewEdge:(NSLayoutAttribute)edge {
  [self pinEdgeToSuperviewEdge:edge inset:0.0];
}

- (void)pinEdgeToSuperviewEdge:(NSLayoutAttribute)edge inset:(CGFloat)inset {
  [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                             attribute:edge
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.superview
                                                             attribute:edge
                                                            multiplier:1.0
                                                              constant:inset]];
}

- (void)pinEdgesToSuperviewEdges {
  [self pinEdgeToSuperviewEdge:NSLayoutAttributeLeading];
  [self pinEdgeToSuperviewEdge:NSLayoutAttributeTop];
  [self pinEdgeToSuperviewEdge:NSLayoutAttributeTrailing];
  [self pinEdgeToSuperviewEdge:NSLayoutAttributeBottom];
}

@end
