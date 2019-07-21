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

@property NSWindowController *windowController;
@property WeftViewController *viewController;
@property WeftApplication *app;
@property WeftWindow *window;

@end

@implementation WeftRunner

- (instancetype)initWithSource:(NSString *)source {
  self = [super init];
  if( self ) {
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
  _windowController = [[NSWindowController alloc] initWithWindow:_window];
  _windowController.contentViewController = self.viewController;
  return _windowController;
}

- (void)close {
  [_windowController close];
}

- (void)setAppDelegate:(id<WeftApplicationDelegate>)appDelegate {
  _app.delegate = appDelegate;
}

@end
