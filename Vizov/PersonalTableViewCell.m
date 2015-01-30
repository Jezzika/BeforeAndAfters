//
//  PersonalTableViewCell.m
//  Vizov
//
//  Created by MiriKunisada on 1/29/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "PersonalTableViewCell.h"



@implementation PersonalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setData:(NSDictionary *)dailyEventLabel{
    
//    if (dailyEventLabel  == 0){
//        
//    
//        
//    }
//    if(![[dailyEventLabel valueForKey:@"detail"] isEqualToString:@""]){
//        self.NoteTitle.text = [dailyEventLabel valueForKey:@"detail"];
//    }

    //    セルに ary を番号順に突っ込む  type:yet or now のみを表示
    //
    //    if ([[homeEventLabel valueForKey:@"type"] isEqualToString:@"now"] || [[homeEventLabel valueForKey:@"type"] isEqualToString:@"yet"]){
    //        self.challebgeTitle.text = [homeEventLabel valueForKeyPath:@"title"];
    //    }
}




@end
