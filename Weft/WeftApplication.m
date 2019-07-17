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

@property NSMapTable<NSString *,NSView *> *elementsById;
@property NSMapTable<NSView *,NSDictionary *> *elementAttributes;

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
    _elementAttributes = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory
                                               valueOptions:NSMapTableStrongMemory];
    _stackHistory = [NSMutableArray array];
  }
  return self;
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

- (void)registerElement:(NSView *)view attributes:(NSDictionary *)attributes {
  [_elementsById setObject:view forKey:[view elementId]];
  [_elementAttributes setObject:attributes forKey:view];
}

- (NSView *)elementWithId:(NSString *)elementId {
  return [_elementsById objectForKey:elementId];
}

- (NSDictionary *)elementAttributes:(NSView *)element {
  return [_elementAttributes objectForKey:element];
}

- (IBAction)buttonPushed:(id)sender {
  NSLog( @"-[WeftApplication buttonPushed:%@]", sender );
  if( self.delegate ) {
    WeftAttribute *attr = [[self elementAttributes:sender] stringAttribute:@"role"];
    if( attr.defined ) {
      if( [attr.stringValue isEqualToString:@"ok"] ) {
        [self.delegate weftApplication:self complete:YES];
        return;
      }
    }

    [self.delegate weftApplication:self
                      buttonPushed:sender];
  }
}


@end
