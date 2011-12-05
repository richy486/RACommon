//
//  RAViewController.m
//  RACommon
//
//  Created by Richy on 5/12/11.
//  Copyright (c) 2011 Richard Adem. All rights reserved.
//
//  richy486@gmail.com
//  twitter.com/richy486
//

#import "RAViewController.h"
#import "RAPopupView.h"
#import "RAVersion.h"

@interface RAViewController()
@property (nonatomic, strong) RAPopupView *popupView;
@end

@implementation RAViewController

@synthesize popupView = _popupView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setPopupView:nil];
}

BOOL firstRun = YES;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (firstRun)
    {
        firstRun = NO;
        RAVersion *version = [[RAVersion alloc] initOnView:self.view];
        [version show];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)touchUpIn_btnPopup:(id)sender
{
    UIView *popupContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [popupContent setBackgroundColor:[UIColor orangeColor]];
    UILabel *popupText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [popupText setText:@"Popup!"];
    [popupText setBackgroundColor:[UIColor clearColor]];
    [popupText setTextAlignment:UITextAlignmentCenter];
    [popupContent addSubview:popupText];
    
    RAPopupView *popup = [[RAPopupView alloc] initWithContentView:popupContent andSuperViewFrame:self.view.frame];
    [self setPopupView:popup];

    [self.view addSubview:self.popupView.view];
    
}
@end
