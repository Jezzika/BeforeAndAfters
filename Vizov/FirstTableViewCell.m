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

- (void)setData:(NSDictionary *)items{
    
        if([[items valueForKey:@"type"] isEqualToString:@"now"]){
            
            NSString *findate = [items valueForKey:@"finDate"];
            
            //初期化
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            
            //日付のフォーマット指定
            df.dateFormat = @"yyyy/MM/dd";
            
            NSDate *today = [NSDate date];
            
            // 日付(NSDate) => 文字列(NSString)に変換
            NSString *strNow = [df stringFromDate:today];
            
            NSDate *currentDate= [df dateFromString:strNow];
            
            NSDate *setFinDate = [df dateFromString:findate];
            
            // dateBとdateAの時間の間隔を取得(dateA - dateBなイメージ)
            NSTimeInterval  since = [setFinDate timeIntervalSinceDate:currentDate];
            int mySince = (int) since/(24*60*60);
            if (mySince > 0){
                
                self.challengeStatus.text = [NSString stringWithFormat:@"%d",mySince];
               
            } else {
                
                self.challengeStatus.text = @"0";
                
            }
            
            self.challegeTitle.text = [items valueForKeyPath:@"title"];
            
            //画像を取得
            NSData *beforePic = [items valueForKey:@"picture"];
            UIImage *beforePic2 = [UIImage imageWithData:beforePic];
            
            self.beforeImageView.image = beforePic2;
            
        }         

}


@end
