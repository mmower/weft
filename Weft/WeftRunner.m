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

- (instancetype)initWithSource:(NSString *)source delegate:(id<WeftApplicationDelegate>)delegate {
  self = [super init];
  if( self ) {
    WeftCompiler *compiler = [[WeftCompiler alloc] initWithSource:source delegate:delegate];
    WeftCompilation *result = [compiler compile];
    if( result.successful ) {
      _app = result.app;
      NSLog( @"app.delegate = %@", _app.delegate );
      _viewController = [[WeftViewController alloc] initWithApplication:_app];
    } else {
      @throw result.exception;
    }
  }
  return self;
}

- (NSWindowController *)run {
  _window = [[WeftWindow alloc] initWithViewController:self.viewController];
  _windowController = [[NSWindowController alloc] initWithWindow:_window];
  _windowController.contentViewController = self.viewController;
  return _windowController;
}

- (void)close {
  [_windowController close];
}

@end
