//
//  WeftApplication.m
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftApplication.h"

#import "WeftParser.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@interface WeftApplication ()

// Mapping from elementId -> NSView
@property NSMapTable<NSString *,NSView *> *elementsById;

// Array of closures that add (elementId,value) tuples to a dictionary
@property NSMutableArray *valueExtractors;

// Stack of NSStackView representing the nested structure of the UI
@property NSMutableArray *stackHistory;

@end

NSInteger kDefaultApplicationWidth = 500;
NSInteger kDefaultApplicationHeight = 200;

@implementation WeftApplication

- (instancetype)init {
  self = [super init];
  if( self ) {
    _elementsById = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
                                          valueOptions:NSMapTableWeakMemory];
    _valueExtractors = [NSMutableArray array];
    _stackHistory = [NSMutableArray array];
    _hasOk = NO;
  }
  return self;
}

- (BOOL)isValid {
  return _hasOk;
}

- (NSArray<NSError *> *)validationErrors {
  if( !_hasOk ) {
    return @[[NSError errorWithDomain:@"WeftApplication"
                                 code:1
                             userInfo:@{@"reason":@"Application has no <ok>"}]];
  } else {
    return @[];
  }
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<WeftApplication:width=%ld:height=%ld:title='%@'>",self.width,self.height,self.title];
}

- (void)pushStack:(NSStackView *)stackview {
  [_stackHistory addObject:_currentStack];
  _currentStack = stackview;
}

- (void)popStack {
  _currentStack = [_stackHistory lastObject];
  [_stackHistory removeLastObject];
}

- (void)addArrangedSubview:(NSView *)view {
  [_currentStack addArrangedSubview:view];
}

- (void)addView:(NSView *)view inGravity:(NSStackViewGravity)gravity {
  [_currentStack addView:view inGravity:gravity];
}

- (NSImage *)provideImage:(NSString *)spec {
  if( self.delegate && [self.delegate respondsToSelector:@selector(weftApplication:provideImage:)] ) {
    return [self.delegate weftApplication:self provideImage:spec];
  } else {
    return nil;
  }
}

- (void)registerElement:(NSView *)view {
  [_elementsById setObject:view forKey:[view elementId]];
}

- (NSView *)elementWithId:(NSString *)elementId {
  return [_elementsById objectForKey:elementId];
}

- (IBAction)buttonPushed:(id)sender {
  if( self.delegate && [self.delegate respondsToSelector:@selector(weftApplication:buttonPushed:)] ) {
    [self.delegate weftApplication:self
                      buttonPushed:sender];
  }
}

- (IBAction)pressedOk:(id)sender {
  [self.delegate weftApplication:self complete:YES];
}

- (IBAction)pressedCancel:(id)sender {
  [self.delegate weftApplication:self complete:NO];
}

- (IBAction)radioSelected:(id)sender {
  if( self.delegate && [self.delegate respondsToSelector:@selector(weftApplication:radioSelected:)] ){
    [self.delegate weftApplication:self
                     radioSelected:sender];
  }
}

- (void)registerExtractor:(WeftValueExtractor)extractor {
  [_valueExtractors addObject:extractor];
}

- (NSDictionary *)values {
  NSMutableDictionary *values = [NSMutableDictionary dictionary];
  for( WeftValueExtractor extractor in _valueExtractors ) {
    extractor(values);
  }
  return values;
}

@end
