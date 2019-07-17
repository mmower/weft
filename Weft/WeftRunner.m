//
//  WeftRunner.m
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftRunner.h"

#import "WeftWindow.h"
#import "WeftViewController.h"

@interface WeftRunner ()

@property WeftWindow *window;
@property NSMapTable *elements;

@end

@implementation WeftRunner

- (instancetype)initWithSource:(NSString *)source {
  self = [super init];
  if( self ) {
    _elements = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory
                                      valueOptions:NSMapTableStrongMemory];
    _controller = [[WeftViewController alloc] initWithSource:source runner:self];
  }
  return self;
}

- (void)run {
  _window = [[WeftWindow alloc] initWithViewController:self.controller];
  NSLog( @"weftRunner.window = %@", _window );
  [_window orderFront:self];
}

- (void)registerElement:(NSView *)view attributes:(NSDictionary *)attributes {
  NSLog( @"registerElement:%@ attribute:%@", view, attributes );
  [_elements setObject:attributes forKey:view];
  NSLog( @"elements now %lu", _elements.count );
}

- (IBAction)buttonPushed:(id)sender {
  NSLog( @"buttonPushed:%@", sender );
  if( self.delegate && [self.delegate respondsToSelector:@selector(weftRunner:buttonPushed:)] ) {
    [self.delegate weftRunner:self
                 buttonPushed:[self.elements objectForKey:sender]];
  }
}

@end
