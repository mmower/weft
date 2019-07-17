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

NS_ASSUME_NONNULL_BEGIN

@protocol WeftRunnerDelegate <NSObject>

- (void)weftRunner:(WeftRunner *)runner buttonPushed:(NSDictionary *)attributes;

@end

@interface WeftRunner : NSObject <NSWindowDelegate>

@property WeftViewController *controller;
@property (weak) id<WeftRunnerDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSource:(NSString *)source NS_DESIGNATED_INITIALIZER;

- (void)registerElement:(NSView *)view attributes:(NSDictionary *)attributes;

- (void)run;

- (IBAction)buttonPushed:(id)sender;

@end

NS_ASSUME_NONNULL_END
