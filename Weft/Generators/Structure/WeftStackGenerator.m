//
//  WeftStackGenerator.m
//  Weft
//
//  Created by Matthew Mower on 21/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WeftStackGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftStackGenerator

- (NSStackView *)createStackWithOrientation:(NSUserInterfaceLayoutOrientation)orientation
                                 attributes:(NSDictionary *)attributes {
  NSStackView *stackView = [[NSStackView alloc] init];
  stackView.distribution = NSStackViewDistributionFill;
  stackView.translatesAutoresizingMaskIntoConstraints = NO;
  stackView.weftAttributes = attributes;
  stackView.orientation = orientation;

  WeftAttribute *attr;

  attr = [attributes floatAttribute:kSpacingAttributeName];
  if( attr.defined ) {
    stackView.spacing = attr.floatValue;
  }

  attr = [attributes distributionAttribute:kDistributionAttributeName];
  if( attr.defined ) {
    stackView.distribution = attr.distributionValue;
  } else {
    stackView.distribution = NSStackViewDistributionFill;
  }

  attr = [attributes insetsAttribute:kInsetsAttributeName];
  if( attr.defined ) {
    stackView.edgeInsets = attr.insetsValue;
  }

  return stackView;
}

@end
