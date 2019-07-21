//
//  WeftStackGenerator.m
//  Weft
//
//  Created by Matthew Mower on 21/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftStackGenerator.h"

#import "NSDictionary+Weft.h"

@implementation WeftStackGenerator

- (NSStackView *)createStackWithOrientation:(NSUserInterfaceLayoutOrientation)orientation
                                 attributes:(NSDictionary *)attributes {
  NSStackView *stackView = [[NSStackView alloc] init];
  stackView.distribution = NSStackViewDistributionFill;
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  stackView.orientation = orientation;

  WeftAttribute *attr = [attributes insetsAttribute:@"insets"];
  if( attr.defined ) {
    stackView.edgeInsets = attr.insetsValue;
  }

  return stackView;
}

@end
