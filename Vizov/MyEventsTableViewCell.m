//
//  MyEventsTableViewCell.m
//  Vizov
//
//  Created by MiriKunisada on 2/8/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "MyEventsTableViewCell.h"

@implementation MyEventsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setData:(NSMutableArray *)eventDaysArySet{
    
//    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *ary        = [usrDefault objectForKey:@"challenges"];
//    NSMutableArray *cameraAry  = [usrDefault objectForKey:@"dailyPictures"];
//    NSMutableArray *selectedDic = [usrDefault objectForKey:@"selectedDic"];
//    
//    //カメラで撮影された画像 UserDefault
//    NSMutableArray *selectedPic = [usrDefault objectForKey:@"selectedPic"];
//    NSData *selectedPicture = [selectedPic valueForKey:@"picture"];
    

    
    self.date.text =  [NSString stringWithFormat:@"%@ですよ！",eventDaysArySet];
    
//    //カメラで撮影したイメージ（セルの日付とマッチしたもの）を取り出す
//    NSData *picData   = [NSData new];
//    for (NSDictionary *dic in cameraAry) {
//        if ([[dic valueForKey:@"date"] isEqualToString:eventDaysArySet] && [[dic valueForKey:@"id"] isEqualToNumber:[selectedDic valueForKey:@"id"]]) {
//            picData = [dic valueForKey:@"picture"];
//        }
//    }
//    
//    // NSData→UIImage変換
//    UIImage *setPic = [UIImage imageWithData:picData];
    
//    self.DailyPicture.image = setPic;

    
}
@end
