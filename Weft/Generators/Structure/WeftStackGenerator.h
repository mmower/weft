//
//  WeftStackGenerator.h
//  Weft
//
//  Created by Matthew Mower on 21/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftElementGenerator.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeftStackGenerator : WeftElementGenerator

- (NSStackView *)createStackWithOrientation:(NSUserInterfaceLayoutOrientation)orientation
                                 attributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
