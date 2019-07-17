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

@dynamic elementId;

- (NSString *)elementId {
  return (NSString *)objc_getAssociatedObject( self, @selector(elementId) );
}

- (void)setElementId:(NSString *)elementId {
  objc_setAssociatedObject( self, @selector(elementId), elementId, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}


@end
