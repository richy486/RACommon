//
//  Popup.m
//  RACommon
//
//  Created by Richard Adem on 24/10/11.
//  Copyright (c) 2011 Richard Adem. All rights reserved.
//
//  richy486@gmail.com
//  twitter.com/richy486
//

#import "RAPopupView.h"
#import <QuartzCore/QuartzCore.h>

@interface RAPopupView()
@property (nonatomic, retain) UIView *contentView;
@end

@implementation RAPopupView
@synthesize viewHolder = _viewHolder;
@synthesize box = _box;
@synthesize innerBox = _innerBox;
@synthesize btnClose = _btnClose;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize contentView = _contentView;

NSString *kPopupCloseNotification = @"kPopupCloseNotification";

- (id) initWithContentView:(UIView*) contentView
{
    //self = [super initWithNibName:@"RAPopupView" bundle:nil];
    self = [super init];
    if (self)
    {
        [self setContentView:contentView];
        //[self.view setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
    return NO;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.innerBox.layer.cornerRadius = 10.0;
    self.box.layer.cornerRadius = 15.0;
    [self.innerBox addSubview:self.contentView];
    
    CGFloat boxW = self.contentView.frame.size.width + 10.0;
    CGFloat boxH = self.contentView.frame.size.height + 10.0;
    
    [self.box setFrame:CGRectMake((self.view.frame.size.width / 2) - (boxW / 2)
                                  , (self.view.frame.size.height / 2) - (boxH / 2)
                                  , boxW
                                  , boxH)];
    
    [self.innerBox setFrame:CGRectMake(5.0
                                  , 5.0
                               , boxW - 10.0
                               , boxH - 10.0)];
    
    [self.backgroundImageView setFrame:CGRectMake(0.0
                                                  , 0.0
                                                  , boxW - 10.0
                                                  , boxH - 10.0)];
    
    [self.btnClose setFrame:CGRectMake(CGRectGetMaxX(self.box.frame) - (self.btnClose.frame.size.width / 2)
                                       , self.box.frame.origin.y - (self.btnClose.frame.size.height / 2)
                                       , self.btnClose.frame.size.width
                                       , self.btnClose.frame.size.height)];
    
    self.viewHolder.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration: 0.2
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.viewHolder.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         [self.view setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
                         
                     }
                     completion:^(BOOL finished){
                     }];
     
}

- (void)viewDidUnload
{
    [self setViewHolder:nil];
    [self setBox:nil];
    [self setTitle:nil];
    [self setBtnClose:nil];
    [self setInnerBox:nil];
    [self setBackgroundImageView:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
- (void)dealloc
{
    [_viewHolder release];
    [_box release];
    [_btnClose release];
    [_innerBox release];
    [_backgroundImageView release];
    [_contentView release];
    [super dealloc];
}
 */

- (IBAction)touchUpIn_btnClose:(id)sender
{
    [UIView animateWithDuration: 0.2
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.viewHolder.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         [self.view setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
                     }
                     completion:^(BOOL finished){
                         [[NSNotificationCenter defaultCenter] postNotificationName:kPopupCloseNotification object:nil];
                         [self.view removeFromSuperview];
                     }];
}

@end
