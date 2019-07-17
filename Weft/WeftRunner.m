//
//  WeftRunner.m
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftRunner.h"

#import "WeftWindow.h"
#import "WeftCompiler.h"
#import "WeftApplication.h"
#import "WeftViewController.h"

@interface WeftRunner ()

@property WeftViewController *viewController;
@property WeftApplication *app;
@property WeftWindow *window;
@property NSMapTable *elements;

@end

@implementation WeftRunner

- (instancetype)initWithSource:(NSString *)source {
  self = [super init];
  if( self ) {
    _elements = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory
                                      valueOptions:NSMapTableStrongMemory];
    WeftCompiler *compiler = [[WeftCompiler alloc] initWithSource:source];
    WeftCompilation *result = [compiler compile];
    if( result.successful ) {
      NSLog( @"Compilation successful: app->%@", result.app );
      _app = result.app;
    } else {
      @throw result.exception;
    }
    _viewController = [[WeftViewController alloc] initWithApplication:_app];
  }
  return self;
}

- (NSWindowController *)run {
  NSLog( @"WeftRunner.run" );
  _window = [[WeftWindow alloc] initWithViewController:self.viewController];
  NSWindowController *windowController = [[NSWindowController alloc] initWithWindow:_window];
  windowController.contentViewController = self.viewController;
  return windowController;
}

- (void)registerElement:(NSView *)view attributes:(NSDictionary *)attributes {
  NSLog( @"registerElement:%@ attribute:%@", view, attributes );
  [_elements setObject:attributes forKey:view];
  NSLog( @"elements now %lu", _elements.count );
}

- (void)setAppDelegate:(id<WeftApplicationDelegate>)appDelegate {
  _app.delegate = appDelegate;
}

@end
