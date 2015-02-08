//
//  ListTableViewCell.m
//  Vizov
//
//  Created by MiriKunisada on 2/6/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)doneItems{

    //タイトル
    self.titleLabel.text = [doneItems valueForKeyPath:@"title"];
    
    //beforePicture
    NSData *pictData = [doneItems valueForKeyPath:@"picture"];
    
    // NSData→UIImage変換
    UIImage *picture = [UIImage imageWithData:pictData];
    
    self.beforeImage.image = picture;
    
    //かかった期間
    self.totalDays.text = [doneItems valueForKey:@"timer"];
    

    
    
}


@end
