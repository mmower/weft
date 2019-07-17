//
//  WeftParser.h
//  weft
//
//  Created by Matthew Mower on 15/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WeftRunner;

NS_ASSUME_NONNULL_BEGIN

@interface WeftParser : NSObject <NSXMLParserDelegate>

@property (readonly) NSArray<NSError *> *errors;
@property (readonly) NSView *rootView;
@property (readonly) NSDictionary *attributes;

- (instancetype)initWithRunner:(WeftRunner *)runner;

@end

@interface WeftMainView : NSView
@end

NS_ASSUME_NONNULL_END
