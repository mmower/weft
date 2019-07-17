//
//  WeftParser.m
//  weft
//
//  Created by Matthew Mower on 15/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftParser.h"

#import "WeftApplication.h"
#import "WeftElementGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@interface WeftParser ()

@property NSMutableDictionary *attributes;
@property NSString *foundCharacters;
@property (readwrite) NSMutableArray<NSError *> *errors;
@property NSMutableArray *stackHistory;
@property NSMutableArray *generators;

@property WeftElementGenerator *generator;


@property WeftApplication *app;

@end

@implementation WeftParser

- (instancetype)initWithApp:(WeftApplication *)app {
  self = [super init];
  if( self ) {
    _app = app;
    _errors = [NSMutableArray array];
    _stackHistory = [NSMutableArray array];
    _generators = [NSMutableArray array];
  }
  return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
  if( _generator ) {
    [_generators addObject:_generator];
  }

  _generator = [WeftElementGenerator generator:elementName];
  if( !_generator ) {
    [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                           code:2
                                       userInfo:@{@"line":@(parser.lineNumber),
                                                  @"column":@(parser.columnNumber),
                                                  @"cause":[NSString stringWithFormat:@"Cannot find generator for '%@' element",elementName]}]];
  } else {
    @try {
      [_generator openElementApp:self.app
                      attributes:attributeDict];
    }
    @catch( NSException *ex ) {
      [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                             code:1
                                         userInfo:@{@"line":@(parser.lineNumber),
                                                    @"column":@(parser.columnNumber),
                                                    @"cause":ex.reason}]];
    }
  }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(nonnull NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI
 qualifiedName:(nullable NSString *)qName
{
  if( ![_generator validForElementName:elementName] ) {
    [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                           code:3
                                       userInfo:@{@"line":@(parser.lineNumber),
                                                  @"column":@(parser.columnNumber),
                                                  @"reason":[NSString stringWithFormat:@"Generator %@ was not expecting to find a closing element: %@",[_generator className],elementName]}]];
  } else {
    @try {
      [_generator closeElementApp:self.app];
    }
    @catch( NSException *ex ) {
      [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                             code:4
                                         userInfo:@{@"line":@(parser.lineNumber),
                                                    @"column":@(parser.columnNumber),
                                                    @"reason":ex.reason}]];
    }
    @finally {
      if( _generators.count > 0 ) {
        _generator = [_generators lastObject];
        [_generators removeLastObject];
      }
    }
  }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
  self.foundCharacters = string;
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
  self.foundCharacters = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
}


@end

