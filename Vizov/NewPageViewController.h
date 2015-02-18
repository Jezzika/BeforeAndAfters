//
//  NewPageViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UIImage+FlatUI.h"
#import "NSString+Icons.h"
#import "FUIAlertView.h"
#import "FUITextField.h"


@interface NewPageViewController : UIViewController


@property (weak, nonatomic) IBOutlet FUITextField *makeNewTitle;
@property (weak, nonatomic) IBOutlet UIImageView *beforeImageView;
@property (weak, nonatomic) IBOutlet UITextView *makeNewDetail;
@property (assign, nonatomic) NSArray *CellNames;


- (IBAction)returnNewTitle:(id)sender;
- (IBAction)showCameraSheet:(id)sender;
- (IBAction)tapNowButton:(id)sender;
- (IBAction)finishDateBtn:(id)sender;

@property (weak, nonatomic) IBOutlet FUIButton *NowBtnDesign;
@property (weak, nonatomic) IBOutlet UILabel *beforeLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishDateLabel;


@end
