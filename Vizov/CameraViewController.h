//
//  CameraViewController.h
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
#import "FUITextField.h"
#import "FUISegmentedControl.h"
#import "UITableViewCell+FlatUI.h"
#import "FUICellBackgroundView.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"

@interface CameraViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *cameraPic;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtnItem;


@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtnItem;

- (IBAction)selectPhotoBtn:(id)sender;


- (IBAction)cancelBtn:(id)sender;

- (IBAction)saveBtn:(id)sender;


@end
