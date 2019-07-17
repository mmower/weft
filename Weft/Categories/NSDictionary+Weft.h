//
//  NSDictionary+Weft.h
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeftAttribute : NSObject

@property (readonly) BOOL defined;
@property (readonly) NSString *stringValue;
@property (readonly) NSInteger integerValue;
@property (readonly) BOOL boolValue;
@property (readonly) NSEdgeInsets insetsValue;
@property (readonly) NSStackViewGravity gravityValue;
@property (readonly) NSUserInterfaceLayoutOrientation orientationValue;

+ (instancetype)undefined;

- (instancetype)initUndefined;
- (instancetype)initStringValue:(NSString *)value;
- (instancetype)initIntegerValue:(NSInteger)value;
- (instancetype)initBoolValue:(BOOL)value;
- (instancetype)initInsetsValue:(NSEdgeInsets)value;
- (instancetype)initGravityValue:(NSStackViewGravity)value;
- (instancetype)initOrientationValue:(NSUserInterfaceLayoutOrientation)value;

@end

@interface NSDictionary (Weft)

- (WeftAttribute *)stringAttribute:(NSString *)name;
- (WeftAttribute *)integerAttribute:(NSString *)name;
- (WeftAttribute *)boolAttribute:(NSString *)name;
- (WeftAttribute *)insetsAttribute:(NSString *)name;
- (WeftAttribute *)gravityAttribute:(NSString *)name;
- (WeftAttribute *)orientiationAttribute:(NSString *)name;

@end

NS_ASSUME_NONNULL_END