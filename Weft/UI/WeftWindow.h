//
//  WeftWindow.h
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WeftViewController;

NS_ASSUME_NONNULL_BEGIN

@interface WeftWindow : NSWindow

- (instancetype)initWithContentRect:(NSRect)contentRect styleMask:(NSWindowStyleMask)style backing:(NSBackingStoreType)backingStoreType defer:(BOOL)flag NS_UNAVAILABLE;

- (instancetype)initWithViewController:(WeftViewController *)controller NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
