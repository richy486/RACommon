//
//  RAVersion.m
//  RACommon
//
//  Created by Richard Adem on 18/10/11.
//  Copyright (c) 2011 Richard Adem. All rights reserved.
//
//  richy486@gmail.com
//  twitter.com/richy486
//

#import "RAVersion.h"
#import <QuartzCore/QuartzCore.h>

@implementation RAVersion

- (id) initOnView:(UIView*) superView
{
    CGRect viewFrame = CGRectMake(0, 0, 200, 50);
    
    self = [super initWithFrame:viewFrame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        CGRect textFrame = CGRectMake(0, 0, 200, 50);
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        UILabel *lbl = [[UILabel alloc] init];
        [lbl setFrame:textFrame];
        [lbl setText:[NSString stringWithFormat:@"v%@ - build: %@", version, build]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:UITextAlignmentCenter];
        
        [self addSubview:lbl];
        //[lbl release];
        
        [self.layer setCornerRadius:10.0];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 10;
        self.clipsToBounds = NO;
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
        [self setAlpha:0.0];
        
        [superView addSubview:self];
        
        [UIView animateWithDuration: 0.3
                              delay: 1.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [self setAlpha:1.0];
                         }
                         completion:^(BOOL finished){
                             [NSTimer scheduledTimerWithTimeInterval:3
                                                              target:self 
                                                            selector:@selector(removeView) 
                                                            userInfo:nil 
                                                             repeats:NO];
                         }];
        
    }
    return self;
}

- (void) removeView
{
    [UIView animateWithDuration: 0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self setAlpha:0.0];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

@end
