//
//  RAPopup.m
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
@synthesize innerBox = _innerBox;
@synthesize btnClose = _btnClose;
@synthesize contentView = _contentView;

NSString *kPopupCloseNotification = @"kPopupCloseNotification";

- (id) initWithContentView:(UIView*) contentView andSuperViewFrame:(CGRect) superViewFrame
{
    self = [super init];
    if (self)
    {
        [self setContentView:contentView];
        [self.view setFrame: CGRectMake(0, 0, superViewFrame.size.width, superViewFrame.size.height)];
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
    
    // setup interface
    self.view.backgroundColor = [UIColor clearColor];
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    self.viewHolder = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.viewHolder];
    
    self.innerBox = [[UIView alloc] initWithFrame:CGRectMake(20, 167, 280, 182)];
    [self.viewHolder addSubview:self.innerBox];
    
    self.btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnClose.frame = CGRectMake(227, 150, 40, 40);
    [self.btnClose setImage:[UIImage imageNamed:@"RAPopupViewBtnClose.png"] forState:UIControlStateNormal];
    [self.btnClose addTarget:self action:@selector(touchUpIn_btnClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewHolder addSubview:self.btnClose];

    // add style
    self.innerBox.layer.cornerRadius = 10.0;
    self.innerBox.layer.borderWidth = 5.0;
    self.innerBox.layer.borderColor = [UIColor whiteColor].CGColor;
    self.innerBox.backgroundColor = [UIColor whiteColor];
    self.innerBox.clipsToBounds = YES;
    [self.innerBox addSubview:self.contentView];
    
    [self.contentView setFrame:CGRectMake(5.0, 5.0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    
    CGFloat boxW = self.contentView.frame.size.width + 10.0;
    CGFloat boxH = self.contentView.frame.size.height + 10.0;
    
    [self.innerBox setFrame:CGRectMake((self.view.frame.size.width / 2) - (boxW / 2)
                                  , (self.view.frame.size.height / 2) - (boxH / 2)
                                  , boxW
                                  , boxH)];
    
    [self.btnClose setFrame:CGRectMake(CGRectGetMaxX(self.innerBox.frame) - (self.btnClose.frame.size.width / 2)
                                       , self.innerBox.frame.origin.y - (self.btnClose.frame.size.height / 2)
                                       , self.btnClose.frame.size.width
                                       , self.btnClose.frame.size.height)];
    
    self.viewHolder.transform = CGAffineTransformMakeScale(0.01, 0.01);
    self.view.alpha = 0.0;
    [UIView animateWithDuration: 0.2
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.viewHolder.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         self.view.alpha = 1.0;
                         self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
                     }
                     completion:^(BOOL finished){
                     }];
     
}

- (void)viewDidUnload
{
    [self setViewHolder:nil];
    [self setTitle:nil];
    [self setBtnClose:nil];
    [self setInnerBox:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)touchUpIn_btnClose:(id)sender
{
    [UIView animateWithDuration: 0.2
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.viewHolder.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         self.view.alpha = 0.0;
                         self.view.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished){
                         [[NSNotificationCenter defaultCenter] postNotificationName:kPopupCloseNotification object:nil];
                         [self.view removeFromSuperview];
                     }];
}

@end
