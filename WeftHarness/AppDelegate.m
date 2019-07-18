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

@property (weak) IBOutlet NSTextView *sourceView;
@property (weak) IBOutlet NSTextField *errorField;

@property WeftRunner *runner;

@property NSWindowController *windowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [_errorField setEditable:NO];
  [_sourceView setString:@"<window title='Weft Test Window' width='640' height='480'>\n\
\t<row insets='20,20,20,20'>\n\
\t\t<checkbox title='Bother' id='bother'/>\n\
\t\t<button role='ok' id='main' clicked='foo' title='Press Me'/>\n\
\t\t<textfield label='Name:' id='name' placeholder='John. Q. Public'/>\n\
\t\t<popupbutton id='color' choices='red,green,blue' default='green'/>\n\
\t</row>\n\
</window>"];
}

- (IBAction)doRun:(id)sender {
  @try {
    _runner = [[WeftRunner alloc] initWithSource:[self.sourceView string]];
    [_runner setAppDelegate:self];
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

- (void)weftApplication:(WeftApplication *)app buttonPushed:(NSButton *)button {
  NSDictionary *attributes = [app elementAttributes:button];
  NSLog( @"weftButton pushed: %@", attributes );
}

- (void)weftApplication:(WeftApplication *)app complete:(BOOL)ok {
  [_errorField setStringValue:[app.values description]];
  [_windowController close];
}


@end
