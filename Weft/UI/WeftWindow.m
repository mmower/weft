//
//  WeftWindow.m
//  weft
//
//  Created by Matthew Mower on 16/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftWindow.h"

#import "WeftViewController.h"

@implementation WeftWindow

- (instancetype)initWithViewController:(WeftViewController *)controller {
  NSRect contentRect = NSMakeRect(500, 400, 40, 40);

  NSWindowStyleMask styleMask = NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|NSWindowStyleMaskMiniaturizable;
  self = [super initWithContentRect:contentRect
                          styleMask:styleMask
                            backing:NSBackingStoreBuffered
                              defer:NO];
  self.title = controller.title;
  self.contentViewController = controller;
  self.contentView = controller.view;
  return self;
}

@end
