//
//  ListTableViewCell.m
//  Vizov
//
//  Created by MiriKunisada on 1/27/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)homeEventLabel{
    if([[homeEventLabel valueForKey:@"type"] isEqualToString:@"now"]){
        NSString *timer = [homeEventLabel valueForKey:@"timer"];
        self.challengeStatus.text = timer;
        self.challegeTitle.text = [homeEventLabel valueForKeyPath:@"title"];
    } else {
        self.challengeStatus.text = @"予約";
        self.challegeTitle.text = [homeEventLabel valueForKeyPath:@"title"];
    }
    
}

@end
