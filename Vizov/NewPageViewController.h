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

@property (strong, nonatomic) IBOutlet UITableView *setTableView;




- (IBAction)returnNewTitle:(id)sender;
- (IBAction)showCameraSheet:(id)sender;

- (IBAction)tapNowButton:(id)sender;

@property (weak, nonatomic) IBOutlet FUIButton *NowBtnDesign;

@end
