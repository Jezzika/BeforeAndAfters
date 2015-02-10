//
//  PersonalTableViewCell.h
//  Vizov
//
//  Created by MiriKunisada on 1/29/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalPageViewController.h"
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

@interface PersonalTableViewCell : UITableViewCell<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UILabel *DailyNumber;

- (void)setData:(NSString *)eventDaysArySet;

@property (weak, nonatomic) IBOutlet UIImageView *DailyPicture;
@property (weak, nonatomic) IBOutlet UITextView *DailyTextView;

@end
