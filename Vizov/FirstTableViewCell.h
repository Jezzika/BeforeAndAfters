//
//  ListTableViewCell.h
//  Vizov
//
//  Created by MiriKunisada on 1/27/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *challengeStatus;
@property (strong, nonatomic) IBOutlet UILabel *challegeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *beforeImageView;

- (void)setData:(NSDictionary *)homeEventLabel;



@end
