//
//  WeftApplication.h
//  Weft
//
//  Created by Matthew Mower on 17/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WeftValueExtractor)(NSMutableDictionary *values);

typedef void(^WeftConstraintGenerator)(void);

@class WeftApplication;

extern NSInteger kDefaultApplicationWidth;
extern NSInteger kDefaultApplicationHeight;

@protocol WeftApplicationDelegate <NSObject>

- (void)weftApplication:(WeftApplication *)app
               complete:(BOOL)ok;

@optional

- (void)weftApplication:(WeftApplication *)app
         controlUpdated:(NSControl *)control;

- (void)weftApplication:(WeftApplication *)app
           buttonPushed:(NSButton *)button;

- (void)weftApplication:(WeftApplication *)app
          radioSelected:(NSButton *)radio;

- (void)weftApplication:(WeftApplication *)app
        checkboxToggled:(NSButton *)checkbox;

- (NSImage *)weftApplication:(WeftApplication *)app
                provideImage:(NSString *)spec;

@end

@interface WeftApplication : NSObject

@property NSString *title;
@property NSInteger width;
@property NSInteger height;
@property BOOL hasOk;

@property id<WeftApplicationDelegate> delegate;

@property NSView *appView;

@property NSStackView *currentStack;

- (BOOL)isValid;
- (NSArray<NSError *> *)validationErrors;

- (void)pushStack:(NSStackView *)stackview;
- (void)popStack;

- (NSImage *)provideImage:(NSString *)spec;

- (void)addArrangedSubview:(NSView *)view;
- (void)addView:(NSView *)view inGravity:(NSStackViewGravity)gravity;

- (void)registerElement:(NSView *)view;
- (void)registerExtractor:(WeftValueExtractor)extractor;
- (NSView *)elementWithId:(NSString *)elementId;

- (IBAction)buttonPushed:(id)sender;
- (IBAction)radioSelected:(id)sender;
- (IBAction)checkboxToggled:(id)sender;
- (IBAction)pressedOk:(id)sender;
- (IBAction)pressedCancel:(id)sender;

- (NSControl *)controlWithId:(NSString *)weftId;

- (void)deferConstraint:(WeftConstraintGenerator)generator;
- (void)applyDeferedConstraints;

- (NSDictionary *)values;

@end

NS_ASSUME_NONNULL_END
