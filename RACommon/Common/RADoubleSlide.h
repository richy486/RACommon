//
//  DoubleSlide.h
//  RACommon
//
//  Created by Richard Adem on 24/10/11.
//  Copyright (c) 2011 Richard Adem. All rights reserved.
//
//  richy486@gmail.com
//  twitter.com/richy486
//

#import <UIKit/UIKit.h>

@interface RADoubleSlide : UIControl

@property CGFloat leftPos;
@property CGFloat rightPos;

- (void) setLeftButtonImage:(UIImage*) img;
- (void) setRightButtonImage:(UIImage*) img;
- (void) setSliderEmptyImage:(UIImage*) img;
- (void) setSLiderFullImage:(UIImage*) img;
@end
