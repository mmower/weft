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

  _generator = [WeftElementGenerator app:self.app element:elementName];
  if( !_generator ) {
    [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                           code:WeftErrorNoGeneratorForElement
                                       userInfo:@{@"line":@(parser.lineNumber),
                                                  @"column":@(parser.columnNumber),
                                                  @"cause":[NSString stringWithFormat:@"Unknown opening <%@> element found",elementName]}]];
    [parser abortParsing];
  } else {
    @try {
      WeftAttribute *idAttr = [attributeDict stringAttribute:kIdAttributeName];
      if( _generator.requiresId && !idAttr.defined ) {
        [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                               code:WeftErrorMissingIdAttribute
                                           userInfo:@{@"line":@(parser.lineNumber),
                                                      @"column":@(parser.columnNumber),
                                                      @"cause":[NSString stringWithFormat:@"<%@> element does not specify 'id' attribute",_generator.elementName]
                                                      }]];
      } else {
        [_generator openElementId:idAttr.stringValue attributes:attributeDict];
      }

      self.foundCharacters = @"";
    }
    @catch( NSException *ex ) {
      [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                             code:WeftErrorExceptionInGenerator
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
                                           code:WeftErrorUnexpectedClosingElement
                                       userInfo:@{@"line":@(parser.lineNumber),
                                                  @"column":@(parser.columnNumber),
                                                  @"cause":[NSString stringWithFormat:@"While parsing <%@> an unexpected closing </%@> was found.", [_generator elementName]
                                                            ,elementName]}]];
  } else {
    @try {
      if( _generator ) {
        [_generator closeElementText:self.foundCharacters];
      }
    }
    @catch( NSException *ex ) {
      [_errors addObject:[NSError errorWithDomain:@"WeftParser"
                                             code:WeftErrorExceptionInGenerator
                                         userInfo:@{@"line":@(parser.lineNumber),
                                                    @"column":@(parser.columnNumber),
                                                    @"cause":ex.reason}]];
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
  if( string ) {
    self.foundCharacters = string;
  } else {
    self.foundCharacters = @"";
  }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
  self.foundCharacters = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
  NSError *error = [NSError errorWithDomain:@"WeftParser"
                                       code:WeftErrorExceptionInGenerator
                                   userInfo:@{@"line":parseError.userInfo[@"NSXMLParserErrorLineNumber"],
                                              @"column":parseError.userInfo[@"NSXMLParserErrorColumn"],
                                              @"cause":parseError.userInfo[@"NSXMLParserErrorMessage"]}];
  [_errors addObject:error];
}

@end
