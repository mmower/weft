//
//  WeftViewController.h
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WeftRunner;

NS_ASSUME_NONNULL_BEGIN

@interface WeftViewController : NSViewController

@property (readonly) NSString *source;
@property (readonly) NSError *error;
@property (readonly) NSDictionary *windowAttributes;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSNibName)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithSource:(NSString *)source runner:(WeftRunner *)runner NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
