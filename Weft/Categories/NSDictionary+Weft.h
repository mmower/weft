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
@property (readonly) NSArray *csvValue;
@property (readonly) NSDate *dateValue;

+ (instancetype)undefined;

- (instancetype)initUndefined;
- (instancetype)initStringValue:(NSString *)value;
- (instancetype)initIntegerValue:(NSInteger)value;
- (instancetype)initBoolValue:(BOOL)value;
- (instancetype)initInsetsValue:(NSEdgeInsets)value;
- (instancetype)initGravityValue:(NSStackViewGravity)value;
- (instancetype)initOrientationValue:(NSUserInterfaceLayoutOrientation)value;
- (instancetype)initCsvValue:(NSArray *)value;
- (instancetype)initDateValue:(NSDate *)value;

@end

@interface NSDictionary (Weft)

- (WeftAttribute *)stringAttribute:(NSString *)name;
- (WeftAttribute *)integerAttribute:(NSString *)name;
- (WeftAttribute *)boolAttribute:(NSString *)name;
- (WeftAttribute *)insetsAttribute:(NSString *)name;
- (WeftAttribute *)gravityAttribute:(NSString *)name;
- (WeftAttribute *)orientiationAttribute:(NSString *)name;
- (WeftAttribute *)csvAttribute:(NSString *)name;
- (WeftAttribute *)dateAttribute:(NSString *)name format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
