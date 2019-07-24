//
//  WeftElementGenerator.h
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WeftApplication.h"

NS_ASSUME_NONNULL_BEGIN

@class WeftAttribute;
@class WeftApplication;
@class WeftGeneratorResult;

extern NSString * const kIdAttributeName;
extern NSString * const kGravityAttributeName;
extern NSString * const kChoicesAttributeName;
extern NSString * const kInsetsAttributeName;
extern NSString * const kTitleAttributeName;
extern NSString * const kDisabledAttributeName;
extern NSString * const kTooltipAttributeName;
extern NSString * const kNameAttributeName;
extern NSString * const kSrcAttributeName;
extern NSString * const kProviderAttributeName;
extern NSString * const kWidthAttributeName;
extern NSString * const kHeightAttributeName;
extern NSString * const kDefaultAttributeName;
extern NSString * const kScrollableAttributeName;
extern NSString * const kEditableAttributeName;
extern NSString * const kSelectableAttributeName;
extern NSString * const kPlaceholderAtributeName;
extern NSString * const kDistributionAttributeName;
extern NSString * const kDateAttributeName;

@interface WeftElementGenerator : NSObject

@property (readonly) WeftApplication *app;

+ (WeftElementGenerator *)app:(WeftApplication *)app element:(NSString *)element;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithApplication:(WeftApplication *)application NS_DESIGNATED_INITIALIZER;

- (void)openElementAttributes:(NSDictionary *)attributes;
- (void)closeElementText:(NSString *)text;

- (NSString *)elementName;
- (BOOL)validForElementName:(NSString *)elementName;

- (NSArray *)choices:(NSDictionary *)attributes;

- (void)addView:(NSView *)view;

- (void)view:(NSView *)view shouldHaveTooltip:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
