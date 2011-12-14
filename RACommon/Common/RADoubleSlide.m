//
//  RADoubleSlide.m
//  RACommon
//
//  Created by Richard Adem on 24/10/11.
//  Copyright (c) 2011 Richard Adem. All rights reserved.
//
//  richy486@gmail.com
//  twitter.com/richy486
//

#import "RADoubleSlide.h"

//#define KEEP_DEBUG_BACKGROUNDS // use this to show backgrounds when using images

@interface RADoubleSlide()
{
    CGFloat _leftHalfWidth;
    CGFloat _rightHalfWidth;
    CGFloat _moveLength;
}

@property (nonatomic, retain) UIButton *btnLeft;
@property (nonatomic, retain) UIButton *btnRight;
@property (nonatomic, retain) UIImageView *empty;
@property (nonatomic, retain) UIImageView *fill;

- (void) updateLeftPos;
- (void) updateRightPos;
- (void) updateFillImage;
@end

@implementation RADoubleSlide

@synthesize btnLeft = _btnLeft;
@synthesize btnRight = _btnRight;
@synthesize leftPos = _leftPos;
@synthesize rightPos = _rightPos;
@synthesize empty = _empty;
@synthesize fill = _fill;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor orangeColor];
        
        self.btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnLeft.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
        self.btnLeft.backgroundColor = [UIColor redColor];
        self.btnLeft.contentMode = UIViewContentModeCenter;
        [self.btnLeft addTarget:self action:@selector(dragInside_btnLeft:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:self.btnLeft];
        
        self.btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnRight.frame = CGRectMake(self.frame.size.width - self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
        self.btnRight.backgroundColor = [UIColor blueColor];
        self.btnRight.contentMode = UIViewContentModeCenter;
        [self.btnRight addTarget:self action:@selector(dragInside_btnRight:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [self addSubview:self.btnRight];
        
        _leftHalfWidth = self.btnLeft.frame.size.width / 2;
        _rightHalfWidth = self.btnRight.frame.size.width / 2;
        _moveLength = self.frame.size.width - _leftHalfWidth - _rightHalfWidth;
        [self updateLeftPos];
        [self updateRightPos];
        
        UIImageView *empty = [[UIImageView alloc] init];
        self.empty = empty;
        //[empty release];
        [self.empty setFrame:self.bounds];
        [self.empty setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:empty];
        
        UIImageView *fill = [[UIImageView alloc] init];
        self.fill = fill;
        //[fill release];
        [self.fill setFrame:self.bounds];
        [self.fill setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:fill];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) updateLeftPos
{
    self.leftPos = (self.btnLeft.center.x - _leftHalfWidth) / _moveLength;
}
- (void) updateRightPos
{
    self.rightPos = (self.btnRight.center.x - _rightHalfWidth) / _moveLength;
}

- (void) dragInside_btnLeft:(id) sender withEvent:(UIEvent *) event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    
    UIControl *control = sender;
    
    point.y = self.frame.size.height / 2;
    point.x = MAX(_leftHalfWidth, point.x);
    
    point.x = MIN(self.btnRight.center.x - _leftHalfWidth, point.x);
    
    control.center = point;
    
    [self updateLeftPos];
    [self updateFillImage];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void) dragInside_btnRight:(id) sender withEvent:(UIEvent *) event
{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    
    UIControl *control = sender;
    
    point.y = self.frame.size.height / 2;
    point.x = MIN(self.frame.size.width - _rightHalfWidth, point.x);
    point.x = MAX(self.btnLeft.center.x + _rightHalfWidth, point.x);
    
    control.center = point;

    [self updateRightPos];
    [self updateFillImage];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

/*
- (void) dealloc
{
    [_btnLeft release];
    [_btnRight release];
    [_empty release];
    [_fill release];
    [super dealloc];
}
 */

- (void) setupOrder
{
    [self sendSubviewToBack:self.fill];
    [self sendSubviewToBack:self.empty];
}

- (void) setLeftButtonImage:(UIImage*) img
{
    [self.btnLeft setImage:img forState:UIControlStateNormal];
#ifndef KEEP_DEBUG_BACKGROUNDS
    [self.btnLeft setBackgroundColor:[UIColor clearColor]];
#endif
}
- (void) setRightButtonImage:(UIImage*) img
{
    [self.btnRight setImage:img forState:UIControlStateNormal];
#ifndef KEEP_DEBUG_BACKGROUNDS
    [self.btnRight setBackgroundColor:[UIColor clearColor]];
#endif
}
- (void) setSliderEmptyImage:(UIImage*) img
{
    CGFloat imgHeight = img.size.height;
    [self.empty setImage:img];
    self.empty.frame = CGRectMake(_leftHalfWidth
                                  , (self.frame.size.height / 2) - (imgHeight / 2)
                                  , _moveLength
                                  , imgHeight);
    [self setupOrder];
#ifndef KEEP_DEBUG_BACKGROUNDS
    [self setBackgroundColor: [UIColor clearColor]];
#endif
}
- (void) setSLiderFullImage:(UIImage*) img
{
    [self.fill setImage:img];
    [self updateFillImage];
    [self setupOrder];
}

- (void) updateFillImage
{
    CGFloat imgHeight = self.fill.image.size.height;
    self.fill.frame = CGRectMake(self.btnLeft.center.x
                                 , (self.frame.size.height / 2) - (imgHeight / 2)
                                 , self.btnRight.center.x - self.btnLeft.center.x
                                 , imgHeight);
}


@end
