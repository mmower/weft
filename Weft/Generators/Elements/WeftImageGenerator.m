//
//  WeftImageGenerator.m
//  Weft
//
//  Created by Matthew Mower on 18/07/2019.
//  Copyright © 2019 TAON. All rights reserved.
//

#import "WeftImageGenerator.h"

#import "NSView+Weft.h"
#import "NSDictionary+Weft.h"

@implementation WeftImageGenerator

- (BOOL)validForElementName:(NSString *)elementName {
  return [[elementName lowercaseString] isEqualToString:@"image"];
}

- (NSImage *)app:(WeftApplication *)app getImage:(NSDictionary *)attributes {
  WeftAttribute *attr;

  attr = [attributes stringAttribute:@"name"];
  if( attr.defined ) {
    return [NSImage imageNamed:attr.stringValue];
  }

  attr = [attributes urlAttribute:@"src"];
  if( attr.defined ) {
    NSLog( @"Loading image from %@", attr.urlValue.absoluteString );
    return [[NSImage alloc] initWithContentsOfURL:attr.urlValue];
  }

  attr = [attributes stringAttribute:@"provider"];
  if( attr.defined ) {
    return [app provideImage:attr.stringValue];
  }

  return nil;
}

- (void)openElementApp:(WeftApplication *)app attributes:(NSDictionary *)attributes {
  WeftAttribute *attr;

  NSImage *image = [self app:app getImage:attributes];
  if( !image ) {
    @throw [NSException exceptionWithName:@"Image Error"
                                   reason:@"Could not find image for <image>"
                                 userInfo:attributes];
  }

  NSImageView *imageView = [NSImageView imageViewWithImage:image];
  imageView.translatesAutoresizingMaskIntoConstraints = NO;
  imageView.imageScaling = NSImageScaleAxesIndependently;

  attr = [attributes gravityAttribute:@"gravity"];
  if( attr.defined ) {
    [app addView:imageView inGravity:attr.gravityValue];
  } else {
    [app addArrangedSubview:imageView];
  }

  NSUInteger width;
  attr = [attributes integerAttribute:@"width"];
  if( attr.defined ) {
    width = attr.integerValue;
  } else {
    width = image.size.width;
  }
  [self app:app autoPinWidthOfView:imageView width:width];

  NSUInteger height;
  attr = [attributes integerAttribute:@"height"];
  if( attr.defined ) {
    height = attr.integerValue;
  } else {
    height = image.size.height;
  }
  [self app:app autoPinHeightOfView:imageView height:height];
}

- (void)closeElementApp:(WeftApplication *)app foundCharacters:(NSString *)foundChars {
}

@end
