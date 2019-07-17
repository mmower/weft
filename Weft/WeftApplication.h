//
//  WeftApplication.h
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class WeftApplication;

extern NSInteger kDefaultApplicationWidth;
extern NSInteger kDefaultApplicationHeight;

@protocol WeftApplicationDelegate <NSObject>

- (void)weftApplication:(WeftApplication *)app
               complete:(BOOL)ok;

- (void)weftApplication:(WeftApplication *)app
           buttonPushed:(NSButton *)button;

@end

@interface WeftApplication : NSObject

@property NSString *title;
@property NSInteger width;
@property NSInteger height;

@property id<WeftApplicationDelegate> delegate;

@property NSWindow *window;
@property NSView *appView;

@property NSStackView *currentStack;

- (void)pushStack:(NSStackView *)stackview;
- (void)popStack;

- (void)addArrangedSubview:(NSView *)view;
- (void)addView:(NSView *)view inGravity:(NSStackViewGravity)gravity;

- (void)registerElement:(NSView *)view attributes:(NSDictionary *)attributes;
- (NSView *)elementWithId:(NSString *)elementId;
- (NSDictionary *)elementAttributes:(NSView *)element;

- (IBAction)buttonPushed:(id)sender;

@end

NS_ASSUME_NONNULL_END
