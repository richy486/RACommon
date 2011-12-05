//
//  Popup.h
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

@property (retain, nonatomic) IBOutlet UIView *viewHolder;
@property (retain, nonatomic) IBOutlet UIView *innerBox;
@property (retain, nonatomic) IBOutlet UIButton *btnClose;
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (id) initWithContentView:(UIView*) contentView;
- (IBAction)touchUpIn_btnClose:(id)sender;
@end
