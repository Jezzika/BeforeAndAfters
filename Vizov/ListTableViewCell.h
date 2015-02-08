//
//  ListTableViewCell.h
//  Vizov
//
//  Created by MiriKunisada on 2/6/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

- (void)setData:(NSMutableArray *)challengesDone;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *beforeImage;
@property (strong, nonatomic) IBOutlet UIImageView *afterImage;
@property (weak, nonatomic) IBOutlet UILabel *totalDays;

@end

