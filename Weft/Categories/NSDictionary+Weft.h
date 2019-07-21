//
//  NSDictionary+Weft.h
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
  WeftStringAttribute,
  WeftIntegerAttribute,
  WeftBoolAttribute,
  WeftInsetsAttribute,
  WeftGravityAttribute,
  WeftDistributionAttribute,
  WeftOrientationAttribute,
  WeftCsvAttribute,
  WeftDateAttribute,
  WeftUrlAttribute,
} WeftAttributeType;

@interface WeftAttribute : NSObject

@property (readonly) BOOL defined;
@property (readonly) WeftAttributeType type;
@property (readonly) NSString *stringValue;
@property (readonly) NSInteger integerValue;
@property (readonly) BOOL boolValue;
@property (readonly) NSEdgeInsets insetsValue;
@property (readonly) NSStackViewGravity gravityValue;
@property (readonly) NSStackViewDistribution distributionValue;
@property (readonly) NSUserInterfaceLayoutOrientation orientationValue;
@property (readonly) NSArray *csvValue;
@property (readonly) NSDate *dateValue;
@property (readonly) NSURL *urlValue;

+ (instancetype)undefined;

- (instancetype)initUndefined;
- (instancetype)initStringValue:(NSString *)value;
- (instancetype)initIntegerValue:(NSInteger)value;
- (instancetype)initBoolValue:(BOOL)value;
- (instancetype)initInsetsValue:(NSEdgeInsets)value;
- (instancetype)initGravityValue:(NSStackViewGravity)value;
- (instancetype)initDistributionValue:(NSStackViewDistribution)value;
- (instancetype)initOrientationValue:(NSUserInterfaceLayoutOrientation)value;
- (instancetype)initCsvValue:(NSArray *)value;
- (instancetype)initDateValue:(NSDate *)value;
- (instancetype)initUrlValue:(NSURL *)value;

@end

@interface NSDictionary (Weft)

- (WeftAttribute *)stringAttribute:(NSString *)name;
- (WeftAttribute *)integerAttribute:(NSString *)name;
- (WeftAttribute *)boolAttribute:(NSString *)name;
- (WeftAttribute *)insetsAttribute:(NSString *)name;
- (WeftAttribute *)gravityAttribute:(NSString *)name;
- (WeftAttribute *)distributionAttribute:(NSString *)name;
- (WeftAttribute *)orientiationAttribute:(NSString *)name;
- (WeftAttribute *)csvAttribute:(NSString *)name;
- (WeftAttribute *)dateAttribute:(NSString *)name format:(NSString *)format;
- (WeftAttribute *)urlAttribute:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
