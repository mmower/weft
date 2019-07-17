//
//  AppDelegate.m
//  weftHarness
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "AppDelegate.h"

#import "WeftRunner.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property WeftRunner *runner;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  _runner = [[WeftRunner alloc] initWithSource:@"<window title='Weft Test Window' width='640' height='480'><hstack insets='20,20,20,20'><button gravity='leading' id='main' clicked='foo' title='Press Me'></button><textfield label='gubbins' width='50' id='f' placeholder='foo'></textfield></hstack></window>"];
  _runner.delegate = self;
  [_runner run];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

- (void)weftRunner:(id)runner buttonPushed:(NSDictionary *)attributes {
  NSLog( @"weftButton pushed: %@", attributes );
}


@end
