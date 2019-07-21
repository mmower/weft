//
//  WeftTextboxGenerator.h
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftElementGenerator.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeftTextboxGenerator : WeftElementGenerator

@property NSTextView *textView;

@end

NS_ASSUME_NONNULL_END
