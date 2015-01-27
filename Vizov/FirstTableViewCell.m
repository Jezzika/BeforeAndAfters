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
        self.challengeStatus.text = @"カウント";
    } else {
        self.challengeStatus.text = @"予約";
    }
    
    //セルに ary を番号順に突っ込む  type:yet or now のみを表示
    
    if ([[homeEventLabel valueForKey:@"type"] isEqualToString:@"now"] || [[homeEventLabel valueForKey:@"type"] isEqualToString:@"yet"]){
        self.challebgeTitle.text = [homeEventLabel valueForKeyPath:@"title"];
    }
    
    
}

@end
