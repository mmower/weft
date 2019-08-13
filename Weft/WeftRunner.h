//
//  WeftRunner.h
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WeftRunner;
@class WeftApplication;
@class WeftViewController;

@protocol WeftApplicationDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface WeftRunner : NSObject <NSWindowDelegate>

@property (readonly) WeftApplication *app;
@property (readonly)  WeftViewController *viewController;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSource:(NSString *)source delegate:(nullable id<WeftApplicationDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (NSView *)view;
- (NSWindowController *)run;
- (void)close;

@end

NS_ASSUME_NONNULL_END
