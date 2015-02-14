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



- (void)setData:(NSDictionary *)eventDaysArySet{
    
    //デザイン用のメソッドを作成
    [self objectsDesign];
    
    
    //カメラ撮影でとった写真のデータを取得
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *cameraAry  = [usrDefault objectForKey:@"dailyPictures"];

    
    NSString *day = [eventDaysArySet valueForKey:@"days"];
    NSNumber *setId  = [eventDaysArySet valueForKey:@"id"];
    

    NSLog(@"aa%@",eventDaysArySet);

    //カメラで撮影したイメージ（セルの日付とマッチしたもの）を取り出す
    NSMutableArray *setAry = [NSMutableArray array];
    for (NSDictionary *dic in cameraAry) {
        if ([[dic valueForKey:@"date"] isEqualToString:day] && [[dic valueForKey:@"id"]isEqualToNumber:setId]){
                [setAry addObject:dic];
        }
    }
    

    NSLog(@"おねがいいい%lu",[setAry count]);
    UIImage *setPic;
    NSString *setMemo;
    if ([setAry count] > 0) {
        
        // NSData→UIImage変換
        setPic = [UIImage imageWithData:[[setAry valueForKey:@"picture"]lastObject]];
        NSLog(@"%@",setPic);
        //Memo
        setMemo = [[setAry valueForKey:@"memo"]lastObject];
        
        //データのセット
        self.DailyTextView.text = setMemo;
        self.DailyPicture.image = setPic;
      
        
    }

 
    //画面上にセット日付を取得
    self.DailyNumber.text =  [NSString stringWithFormat:@"%@",[eventDaysArySet valueForKey:@"days"]];



}


- (void)objectsDesign{
    
    //TextViewを編集不可にする処理
    self.DailyTextView.editable = NO;
   
    //TextViewに枠線をつける
    self.DailyTextView.layer.borderWidth = 3;
    self.DailyTextView.layer.borderColor = [[UIColor turquoiseColor] CGColor];
    self.DailyTextView.layer.cornerRadius = 6;
    
    //カウントダウンの丸枠
    self.DailyPicture.layer.cornerRadius = 6;
    self.DailyPicture.clipsToBounds = true;
    
    //日付のデザイン
    self.DailyNumber.backgroundColor = [UIColor turquoiseColor];
    self.DailyNumber.layer.cornerRadius = 3;
    self.DailyNumber.clipsToBounds = true;
    
    NSAttributedString *str = [[NSAttributedString alloc]
                               initWithString:self.DailyTextView.text
                               attributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                            NSFontAttributeName:self.DailyTextView.font}];
    CGSize size = [str size];
    [str drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
}

@end
