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

- (void)closeElementApp:(WeftApplication *)app {
  @throw [NSException exceptionWithName:@"TypeError"
                                 reason:@"Subclass does not define -closeElementApp:"
                               userInfo:@{@"class":self.className}];
}

@end
