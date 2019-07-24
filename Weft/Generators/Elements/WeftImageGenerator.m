//
//  WeftImageGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftImageGenerator.h"

#import "WeftApplication.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

static NSString * const kImageElementName = @"image";

@implementation WeftImageGenerator

- (NSString *)elementName {
  return kImageElementName;
}

- (NSImage *)getImage:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:kNameAttributeName];
  if( attr.defined ) {
    return [NSImage imageNamed:attr.stringValue];
  }

  attr = [attributes urlAttribute:kSrcAttributeName];
  if( attr.defined ) {
    return [[NSImage alloc] initWithContentsOfURL:attr.urlValue];
  }

  attr = [attributes stringAttribute:kProviderAttributeName];
  if( attr.defined ) {
    return [self.app provideImage:attr.stringValue];
  }

  return nil;
}

- (void)openElementAttributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSImage *image = [self getImage:attributes];
  if( !image ) {
    @throw [NSException exceptionWithName:@"Resource Error"
                                   reason:@"Could not find image for <image>"
                                 userInfo:attributes];
  }

  NSImageView *imageView = [NSImageView imageViewWithImage:image];
  imageView.weftAttributes = attributes;
  imageView.translatesAutoresizingMaskIntoConstraints = NO;
  imageView.imageScaling = NSImageScaleAxesIndependently;

  [self addView:imageView ];

  attr = [attributes floatAttribute:kWidthAttributeName];
  if( attr.defined ) {
    [imageView pinWidth:attr.floatValue];
  }

  attr = [attributes integerAttribute:kHeightAttributeName];
  if( attr.defined ) {
    [imageView pinHeight:attr.floatValue];
  }
}

- (void)closeElementText:(NSString *)foundChars {
}

@end
