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

@property (weak) IBOutlet NSTextField *sourceField;
@property (weak) IBOutlet NSTextField *errorField;

@property WeftRunner *runner;

@property NSWindowController *windowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [_errorField setEditable:NO];
  [_sourceField setStringValue:@"<window title='Weft Test Window' width='640' height='480'>\n\
       <row insets='20,20,20,20'>\n\
         <button gravity='leading' id='main' clicked='foo' title='Press Me'></button>\n\
         <textfield gravity='leading' label='Name:' width='50' id='name' placeholder='John. Q. Public'></textfield>\n\
       </row>\n\
   </window>"];
}

- (IBAction)doRun:(id)sender {
  @try {
    _runner = [[WeftRunner alloc] initWithSource:[self.sourceField stringValue]];
    _runner.delegate = self;
    _windowController = [_runner run];
    [_windowController showWindow:self];
  }
  @catch( NSException *ex ) {
    NSLog( @"%@", ex );
    NSBeep();
    NSString *error = [NSString stringWithFormat:@"%@\nInfo:\n%@",ex.reason,ex.userInfo];
    [_errorField setStringValue:error];
  }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

- (void)weftRunner:(id)runner buttonPushed:(NSDictionary *)attributes {
  NSLog( @"weftButton pushed: %@", attributes );
}


@end
