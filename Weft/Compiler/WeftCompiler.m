//
//  WeftCompiler.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftCompiler.h"

#import "WeftParser.h"
#import "WeftApplication.h"

@interface WeftCompiler ()

@property WeftApplication *app;
@property NSString *source;
@property id target;

@end

@implementation WeftCompiler

- (instancetype)initWithSource:(NSString *)source {
  self = [super init];
  if( self ) {
    _source = source;
    _app = [[WeftApplication alloc] init];
  }
  return self;
}

- (WeftCompilation *)compile {
  NSData *sourceData = [_source dataUsingEncoding:NSUTF8StringEncoding];
  NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:sourceData];
  WeftParser *weftParser = [[WeftParser alloc] initWithApp:self.app];
  xmlParser.delegate = weftParser;
  BOOL success = [xmlParser parse];
  if( success ) {
    if( weftParser.errors.count > 0 ) {
      return [[WeftCompilation alloc] initFailure:weftParser.errors];
    } else if( ![self.app isValid] ) {
      return [[WeftCompilation alloc] initFailure:self.app.validationErrors];
    } else {
      return [[WeftCompilation alloc] initSuccess:self.app];
    }
  } else {
    return [[WeftCompilation alloc] initFailure:@[[NSError errorWithDomain:@"WeftCompiler"
                                                                      code:1
                                                                  userInfo:@{@"error":[xmlParser parserError]}]]];
  }
}

@end

@implementation WeftCompilation

- (instancetype)initSuccess:(WeftApplication *)app {
  self = [super init];
  if( self ) {
    _successful = YES;
    _app = app;
  }
  return self;
}

- (instancetype)initFailure:(NSArray<NSError *> *)errors {
  self = [super init];
  if( self ) {
    _successful = NO;
    _errors = errors;
  }
  return self;
}

- (NSException *)exception {
  return [NSException exceptionWithName:@"Compilation Exception"
                                 reason:@"Failed to compile"
                               userInfo:@{@"errors":self.errors}];
}

@end
