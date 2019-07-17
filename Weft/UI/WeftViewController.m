//
//  WeftViewController.m
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftViewController.h"

#import "WeftApplication.h"

@interface WeftViewController ()

@property WeftApplication *app;

@property (readwrite) NSString *source;
@property (readwrite) NSError *error;
@property (readwrite) NSMutableDictionary *windowAttributes;

@end

@implementation WeftViewController

- (instancetype)initWithApplication:(WeftApplication *)app {
  self = [super initWithNibName:nil bundle:nil];
  if( self ) {
    _app = app;
    NSLog( @"WeftViewController:app->%@", _app );
    self.title = _app.title;
  }
  return self;
}

- (void)loadView {
  NSLog( @"WeftViewController.loadView" );
  NSLog( @"Application->%@", _app );
  self.view = _app.appView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

@end
