//
//  PersonalPageViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/22/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalPageViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *settedTitle;
@property (strong, nonatomic) IBOutlet UIImageView *settedBeforePicture;
@property (strong, nonatomic) IBOutlet UILabel *settedTimer;
@property (strong, nonatomic) IBOutlet UITextView *settedDetail;



@property (strong, nonatomic) IBOutlet UITableView *listDetailTable;

@property (nonatomic) BOOL fromFirstView;
@property (nonatomic) BOOL fromNewPageView;

@property (strong, nonatomic) IBOutlet UIButton *toListEventButton;

@end
