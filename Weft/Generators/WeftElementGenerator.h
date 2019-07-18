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

@class WeftGeneratorResult;

@interface WeftElementGenerator : NSObject

+ (WeftElementGenerator *)generator:(NSString *)element;

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes;
- (void)closeElementApp:(WeftApplication *)app;

- (BOOL)validForElementName:(NSString *)elementName;

@end

NS_ASSUME_NONNULL_END
