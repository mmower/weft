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
@class WeftGeneratorResult;

@interface WeftElementGenerator : NSObject

+ (WeftElementGenerator *)generator:(NSString *)element;

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes;
- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars;

- (NSString *)elementName;
- (BOOL)validForElementName:(NSString *)elementName;

- (void)app:(WeftApplication *)app addView:(NSView *)view gravity:(WeftAttribute *)gravity;

- (void)app:(WeftApplication *)app autoPinWidthOfView:(NSView *)view width:(NSInteger)width;
- (void)app:(WeftApplication *)app autoPinWidthOfView:(NSView *)view  attributes:(NSDictionary *)attributes;

- (void)app:(WeftApplication *)app autoPinHeightOfView:(NSView *)view height:(NSInteger)height;
- (void)app:(WeftApplication *)app autoPinHeightOfView:(NSView *)view attributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
