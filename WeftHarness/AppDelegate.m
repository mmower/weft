//
//  AppDelegate.m
//  weftHarness
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "AppDelegate.h"

#import "WeftRunner.h"

#import "NSView+Weft.h"

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

  NSString *path = [[NSBundle mainBundle] pathForResource:@"example1" ofType:@"weft"];
  NSString *code = [NSString stringWithContentsOfFile:path
                                             encoding:NSUTF8StringEncoding
                                                error:NULL];
  [_sourceView setString:code];
}

- (IBAction)doRun:(id)sender {
  @try {
    if( _windowController ) {
      [_windowController close];
    }
    [_errorField setStringValue:@""];

    _runner = [[WeftRunner alloc] initWithSource:[self.sourceView string]
                                        delegate:self];
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
  NSLog( @"weftButton pushed: %@", button.weftAttributes );
}

- (void)weftApplication:(WeftApplication *)app radioSelected:(NSButton *)radio {
  NSLog( @"weftRadio selected: %@", radio );
}

- (void)weftApplication:(WeftApplication *)app checkboxToggled:(NSButton *)checkbox {
  NSLog( @"weftCheckbox toggled: %@", checkbox );
}

- (void)weftApplication:(WeftApplication *)app complete:(BOOL)ok {
  [_errorField setStringValue:[app.values description]];
  [_windowController close];
}

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor {
  NSLog( @"textField:%@ shouldEndEditing:%@", control, fieldEditor );
  return YES;
}

@end
