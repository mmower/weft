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

- (WeftAttribute *)csvAttribute:(NSString *)name {
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  } else {
    return [[WeftAttribute alloc] initCsvValue:[value componentsSeparatedByString:@","]];
  }
}

- (WeftAttribute *)dateAttribute:(NSString *)name format:(NSString *)format {
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  } else {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [[WeftAttribute alloc] initDateValue:[formatter dateFromString:value]];
  }
}

- (WeftAttribute *)urlAttribute:(NSString *)name {
  NSString *value = [self objectForKey:name];
  if( !value ) {
    return [WeftAttribute undefined];
  } else {
    return [[WeftAttribute alloc] initUrlValue:[NSURL URLWithString:value]];
  }
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
    _type = WeftStringAttribute;
  }
  return self;
}

- (instancetype)initIntegerValue:(NSInteger)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _integerValue = value;
    _type = WeftIntegerAttribute;
  }
  return self;
}

- (instancetype)initBoolValue:(BOOL)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _boolValue = value;
    _type = WeftBoolAttribute;
  }
  return self;
}

- (instancetype)initInsetsValue:(NSEdgeInsets)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _insetsValue = value;
    _type = WeftInsetsAttribute;
  }
  return self;
}

- (instancetype)initGravityValue:(NSStackViewGravity)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _gravityValue = value;
    _type = WeftGravityAttribute;
  }
  return self;
}

- (instancetype)initOrientationValue:(NSUserInterfaceLayoutOrientation)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _orientationValue = value;
    _type = WeftOrientationAttribute;
  }
  return self;
}

- (instancetype)initCsvValue:(NSArray *)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _csvValue = value;
    _type = WeftCsvAttribute;
  }
  return self;
}

- (instancetype)initDateValue:(NSDate *)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _dateValue = value;
    _type = WeftDateAttribute;
  }
  return self;
}

- (instancetype)initUrlValue:(NSURL *)value {
  self = [super init];
  if( self ) {
    _defined = YES;
    _urlValue = value;
    _type = WeftUrlAttribute;
  }
  return self;
}

- (NSString *)description {
  if( !_defined ) {
    return @"[attribute.undefined]";
  } else {
    switch( _type ) {
      case WeftStringAttribute:
        return [NSString stringWithFormat:@"[attribute.string=%@]",_stringValue];
      case WeftIntegerAttribute:
        return [NSString stringWithFormat:@"[attribute.integer=%ld]",_integerValue];
      case WeftBoolAttribute:
        return [NSString stringWithFormat:@"[attribute.bool=%@]",[@(_boolValue) stringValue]];
      case WeftInsetsAttribute:
        return [NSString stringWithFormat:@"[attribute.insets=%f,%f,%f,%f]",_insetsValue.top,_insetsValue.left,_insetsValue.right,_insetsValue.bottom];
      case WeftGravityAttribute:
        switch( _gravityValue ) {
          case NSStackViewGravityTop:
            return @"[attribute.gravity=Top|Leading]";
          case NSStackViewGravityBottom:
            return @"[attribute.gravity=Bottom|Trailing]";
          case NSStackViewGravityCenter:
            return @"[attribute.gravity=Center]";
        }
        break;
      case WeftCsvAttribute:
        return [NSString stringWithFormat:@"[attribute.csv=%@]",[_csvValue componentsJoinedByString:@","]];
      case WeftDateAttribute:
        return [NSString stringWithFormat:@"[attribute.date=%@]",_dateValue];
      case WeftUrlAttribute:
        return [NSString stringWithFormat:@"[attribute.url=%@]",_urlValue.absoluteString];
      case WeftOrientationAttribute:
        return [NSString stringWithFormat:@"[attribute.orientation=%@",_orientationValue == NSUserInterfaceLayoutOrientationVertical ? @"V" : @"H"];
    }
  }
}

@end
