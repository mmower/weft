//
//  WeftViewController.m
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftViewController.h"

#import "WeftParser.h"

@interface WeftViewController ()

@property WeftRunner *runner;

@property (readwrite) NSString *source;
@property (readwrite) NSError *error;
@property (readwrite) NSMutableDictionary *windowAttributes;

@end

@implementation WeftViewController

- (instancetype)initWithSource:(NSString *)source runner:(WeftRunner *)runner {
  self = [super initWithNibName:nil bundle:nil];
  if( self ) {
    _runner = runner;
    _source = source;
    self.title = @"Hello from Weft";
//    self.view = [self sillyView];
    NSLog( @"WeftViewController.view = %@", self.view );
  }
  return self;
}

- (void)loadView {
  NSLog( @"WeftViewController.loadView" );
  NSData *sourceData = [_source dataUsingEncoding:NSUTF8StringEncoding];
  NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:sourceData];
  WeftParser *weftParser = [[WeftParser alloc] initWithRunner:self.runner];
  xmlParser.delegate = weftParser;
  BOOL success = [xmlParser parse];
  if( success ) {
    if( weftParser.errors.count == 0 ) {
      self.view = weftParser.rootView;
    } else {
      NSLog( @"Parsing errors:" );
      for( NSError *error in weftParser.errors ) {
        NSLog( @"%@> %@", error.userInfo[@"line"], error.userInfo[@"error"] );
      }
    }
  } else {
    NSLog( @"XML Parsing failed" );
    self.error = [xmlParser parserError];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

@end
