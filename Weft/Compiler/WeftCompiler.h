//
//  WeftCompiler.h
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class WeftApplication;

@interface WeftCompilation : NSObject

@property BOOL successful;
@property WeftApplication *app;
@property NSArray<NSError *> *errors;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initSuccess:(WeftApplication *)app NS_DESIGNATED_INITIALIZER;
- (instancetype)initFailure:(NSArray<NSError *> *)errors NS_DESIGNATED_INITIALIZER;

- (NSException *)exception;

@end

@interface WeftCompiler : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSource:(NSString *)source NS_DESIGNATED_INITIALIZER;

- (WeftCompilation *)compile;

@end

NS_ASSUME_NONNULL_END
