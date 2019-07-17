//
//  NSDictionary+Weft.m
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "NSDictionary+Weft.h"

@implementation NSDictionary (Weft)

- (WeftAttribute *)stringAttribute:(NSString *)name {
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  } else {
    return [[WeftAttribute alloc] initStringValue:value];
  }
}

- (WeftAttribute *)integerAttribute:(NSString *)name {
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  } else {
    return [[WeftAttribute alloc] initIntegerValue:[value integerValue]];

  }
}

- (WeftAttribute *)boolAttribute:(NSString *)name {
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  } else {
    return [[WeftAttribute alloc] initBoolValue:[value boolValue]];
  }
}

- (WeftAttribute *)insetsAttribute:(NSString *)name {
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  }

  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*" options:0 error:nil];

  NSTextCheckingResult *result = [regex firstMatchInString:value options:0 range:NSMakeRange(0, value.length)];
  if( result.numberOfRanges != 5 ) {
    return [WeftAttribute undefined];
  }

  CGFloat top = [[value substringWithRange:[result rangeAtIndex:1]] floatValue];
  CGFloat left = [[value substringWithRange:[result rangeAtIndex:2]] floatValue];
  CGFloat bottom = [[value substringWithRange:[result rangeAtIndex:3]] floatValue];
  CGFloat right = [[value substringWithRange:[result rangeAtIndex:4]] floatValue];
  return [[WeftAttribute alloc] initInsetsValue:NSEdgeInsetsMake(top, left, bottom, right)];
}

- (WeftAttribute *)gravityAttribute:(NSString *)name {
  NSStackViewGravity gravity;
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  } else {
    value = [value lowercaseString];
    if( [value isEqualToString:@"top"] ) {
      gravity = NSStackViewGravityTop;
    } else if( [value isEqualToString:@"leading"] ) {
      gravity = NSStackViewGravityLeading;
    } else if( [value isEqualToString:@"center"] ) {
      gravity = NSStackViewGravityCenter;
    } else if( [value isEqualToString:@"trailing"] ) {
      gravity = NSStackViewGravityTrailing;
    } else if( [value isEqualToString:@"bottom"] ) {
      gravity = NSStackViewGravityBottom;
    } else {
      return [[WeftAttribute alloc] initUndefined];
    }
  }
  return [[WeftAttribute alloc] initGravityValue:gravity];
}

- (WeftAttribute *)orientiationAttribute:(NSString *)name {
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  }

  NSUserInterfaceLayoutOrientation orientation;
  value = [[value lowercaseString] substringToIndex:1];
  if( [value isEqualToString:@"h"] ) {
    orientation = NSUserInterfaceLayoutOrientationHorizontal;
  } else if( [value isEqualToString:@"v"] ) {
    orientation = NSUserInterfaceLayoutOrientationVertical;
  } else {
    return [WeftAttribute undefined];
  }

  return [[WeftAttribute alloc] initOrientationValue:orientation];
}

@end

@implementation WeftAttribute

+ (instancetype)undefined {
  static WeftAttribute *undefinedAttr;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    undefinedAttr = [[WeftAttribute alloc] initUndefined];
  });
  return undefinedAttr;
}

- (instancetype)initUndefined {
  self = [super init];
  if( self ) {
    _defined = NO;
  }
  return self;
}

- (instancetype)initStringValue:(NSString *)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _stringValue = value;
  }
  return self;
}

- (instancetype)initIntegerValue:(NSInteger)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _integerValue = value;
  }
  return self;
}

- (instancetype)initBoolValue:(BOOL)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _boolValue = value;
  }
  return self;
}

- (instancetype)initInsetsValue:(NSEdgeInsets)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _insetsValue = value;
  }
  return self;
}

- (instancetype)initGravityValue:(NSStackViewGravity)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _gravityValue = value;
  }
  return self;
}

- (instancetype)initOrientationValue:(NSUserInterfaceLayoutOrientation)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _orientationValue = value;
  }
  return self;
}

@end
