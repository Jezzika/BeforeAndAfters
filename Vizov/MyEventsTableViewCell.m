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


- (void)setData:(NSMutableDictionary *)eventDaysArySet{
    
    
    //カメラ撮影でとった写真のデータを取得
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *cameraAry  = [usrDefault objectForKey:@"dailyPictures"];
    
    NSString *day = [eventDaysArySet valueForKey:@"days"];
    NSNumber *setId  = [eventDaysArySet valueForKey:@"id"];
    
    
    //カメラで撮影したイメージ（セルの日付とマッチしたもの）を取り出す
    NSMutableArray *setAry = [NSMutableArray array];
    for (NSDictionary *dic in cameraAry) {
        if ([[dic valueForKey:@"date"] isEqualToString:day] && [[dic valueForKey:@"id"]isEqualToNumber:setId]){
            [setAry addObject:dic];
        }
    }
    
    UIImage *setPic;
    NSString *setMemo;
    if ([setAry count] > 0) {
        
        // NSData→UIImage変換
        setPic = [UIImage imageWithData:[[setAry valueForKey:@"picture"]lastObject]];
        
        //Memo
        setMemo = [[setAry valueForKey:@"memo"]lastObject];
        
        //データのセット
        self.setMemo.text = setMemo;
        self.pic.image = setPic;
        self.date.text =  [eventDaysArySet valueForKey:@"days"];
        
    }
    
    //TextViewを編集不可にする処理
    self.setMemo.editable = NO;
    
    //TextViewに枠線をつける
    self.setMemo.layer.borderWidth = 2;
    self.setMemo.layer.borderColor = [[UIColor turquoiseColor] CGColor];
    self.setMemo.layer.cornerRadius = 6;
    
    //日付のデザイン
    self.date.backgroundColor = [UIColor turquoiseColor];
    self.date.textColor = [UIColor whiteColor];
    self.date.layer.cornerRadius = 3;
    self.date.clipsToBounds = true;
    
}
@end
