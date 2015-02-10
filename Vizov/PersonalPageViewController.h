//
//  PersonalPageViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/22/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UIImage+FlatUI.h"
#import "NSString+Icons.h"
#import <FlatUIKit/UIColor+FlatUI.h>
#import "UINavigationBar+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UITableViewCell+FlatUI.h"
#import "FUICellBackgroundView.h"

@interface PersonalPageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *settedTitle;
@property (strong, nonatomic) IBOutlet UILabel *settedTimer;
@property (strong, nonatomic) IBOutlet UITextView *settedDetail;



@property (strong, nonatomic) IBOutlet UITableView *listDetailTable;

@property (nonatomic) BOOL fromFirstView;

@property (strong, nonatomic) UIButton *toListEventButton;
@property (strong, nonatomic) UIImageView *settedBeforePicture;






@end
