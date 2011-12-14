//
//  RAPopup.h
//  RACommon
//
//  Created by Richard Adem on 24/10/11.
//  Copyright (c) 2011 Richard Adem. All rights reserved.
//
//  richy486@gmail.com
//  twitter.com/richy486
//

#import <UIKit/UIKit.h>

extern NSString *kPopupCloseNotification;

@interface RAPopupView : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) UIView *viewHolder;
@property (retain, nonatomic) UIView *innerBox;
@property (retain, nonatomic) UIButton *btnClose;

- (id) initWithContentView:(UIView*) contentView andSuperViewFrame:(CGRect) superViewFrame;
- (IBAction)touchUpIn_btnClose:(id)sender;
@end
