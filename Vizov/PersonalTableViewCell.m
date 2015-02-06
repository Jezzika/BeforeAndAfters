//
//  PersonalTableViewCell.m
//  Vizov
//
//  Created by MiriKunisada on 1/29/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "PersonalTableViewCell.h"
#import "PersonalPageViewController.h"


@implementation PersonalTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setData:(NSDictionary *)tableAry{
    
    
//
//    NSIndexPath *indexPath = dailyEventLabel.indexPathForSelectedRow;
//    NSArray *selectedArray = self.tableArray[indexPath.row];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefault objectForKey:@"selectedAry"];
    NSString *timer = [dict valueForKey:@"timer"];
       NSLog(@"timer: %@", timer);
    int num = [timer intValue];
    
    int i;
    for (i = 1; i<num; i++) {
        self.DailyNumber.text = [NSString stringWithFormat:@"%d日目",i];
    }

    
    NSLog(@"num :%d", num);
    NSLog(@"配列: %@",tableAry);
    NSLog(@"配列の数: %ld",tableAry.count);

//    for (NSString *miri in self.tableary) {
//        NSLog(@"%@",[NSString stringWithFormat:@"%@日目",miri]);
//    }
    

    
    
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
