//
//  WeftElementGenerator.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftElementGenerator.h"

#import "WeftApplication.h"

#import "WeftWindowGenerator.h"
#import "WeftButtonGenerator.h"
#import "WeftTextfieldGenerator.h"
#import "WeftRowGenerator.h"
#import "WeftColGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

static NSMapTable *generators;

@implementation WeftElementGenerator

+ (WeftElementGenerator *)generator:(NSString *)element {
  NSString *className = [NSString stringWithFormat:@"Weft%@Generator",[element capitalizedString]];
  Class generatorClass = NSClassFromString( className );
  WeftElementGenerator *generator = [[generatorClass alloc] init];
  return generator;
}

- (BOOL)validForElementName:(NSString *)elementName {
  @throw [NSException exceptionWithName:@"TypeError"
                                 reason:@"Subclass does not define -validForElementName:"
                               userInfo:@{@"class":self.className}];
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  @throw [NSException exceptionWithName:@"TypeError"
                                 reason:@"Subclass does not define -openElementApp:attributes:"
                               userInfo:@{@"class":self.className}];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
  @throw [NSException exceptionWithName:@"TypeError"
                                 reason:@"Subclass does not define -closeElementApp:"
                               userInfo:@{@"class":self.className}];
}

- (void)app:(WeftApplication *)app addView:(NSView *)view gravity:(WeftAttribute *)gravity {
  if( gravity.defined ) {
    [app addView:view inGravity:gravity.gravityValue];
  } else {
    [app addArrangedSubview:view];
  }
}

- (void)app:(WeftApplication *)app autoPinWidthOfView:(NSView *)view width:(NSInteger)width {
  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:width]];
}

- (void)app:(WeftApplication *)app autoPinWidthOfView:(NSView *)view attributes:(NSDictionary *)attributes {
  WeftAttribute *attr = [attributes integerAttribute:@"width"];
  if( attr.defined ) {
    [self app:app autoPinWidthOfView:view width:attr.integerValue];
  }
}

- (void)app:(WeftApplication *)app autoPinHeightOfView:(NSView *)view height:(NSInteger)height {
  [app.appView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:height]];
}


- (void)app:(WeftApplication *)app autoPinHeightOfView:(NSView *)view attributes:(NSDictionary *)attributes {
  WeftAttribute *attr = [attributes integerAttribute:@"height"];
  if( attr.defined ) {
    [self app:app autoPinHeightOfView:view height:attr.integerValue];
  }
}

@end
