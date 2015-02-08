//
//  PersonalTableViewCell.h
//  Vizov
//
//  Created by MiriKunisada on 1/29/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalPageViewController.h"

@interface PersonalTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *DailyNumber;

- (void)setData:(NSMutableArray *)eventDaysArySet;

@property (weak, nonatomic) IBOutlet UIImageView *DailyPicture;

@end
