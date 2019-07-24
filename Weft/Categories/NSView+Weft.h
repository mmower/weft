//
//  NSView+Weft.h
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Weft)

@property (nonatomic,strong) NSString *elementId;
@property (nonatomic,strong) NSDictionary *weftAttributes;

- (void)pinWidth:(CGFloat)width;
- (void)pinHeight:(CGFloat)height;

- (void)pinEdgeToSuperviewEdge:(NSLayoutAttribute)edge;
- (void)pinEdgeToSuperviewEdge:(NSLayoutAttribute)edge inset:(CGFloat)inset;

@end

NS_ASSUME_NONNULL_END
