//
//  WeftRunner.h
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WeftRunner;
@class WeftViewController;

@protocol WeftApplicationDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface WeftRunner : NSObject <NSWindowDelegate>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSource:(NSString *)source NS_DESIGNATED_INITIALIZER;

- (NSWindowController *)run;
- (void)close;

- (void)setAppDelegate:(id<WeftApplicationDelegate>)appDelegate;

@end

NS_ASSUME_NONNULL_END
