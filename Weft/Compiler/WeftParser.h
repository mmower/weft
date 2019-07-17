//
//  WeftParser.h
//  weft
//
//  Created by Matthew Mower on 15/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WeftApplication;

NS_ASSUME_NONNULL_BEGIN

@interface WeftParser : NSObject <NSXMLParserDelegate>

@property (readonly) NSArray<NSError *> *errors;

- (instancetype)initWithApp:(WeftApplication *)app;

@end

NS_ASSUME_NONNULL_END
