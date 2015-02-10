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



- (void)setData:(NSMutableArray *)eventDaysArySet{
    
    //デザイン用のメソッドを作成
    [self objectsDesign];
    
    
    //カメラ撮影
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary        = [usrDefault objectForKey:@"challenges"];
    NSMutableArray *cameraAry  = [usrDefault objectForKey:@"dailyPictures"];
    NSDictionary *selectedDic = [usrDefault objectForKey:@"selectedDic"];

    //カメラで撮影された画像 UserDefault
    NSMutableArray *selectedPic = [usrDefault objectForKey:@"selectedPic"];
    NSData *selectedPicture = [selectedPic valueForKey:@"picture"];
    NSString *selectedMemo = [selectedPic valueForKey:@"memo"];

    
    //　〃（メモ）
    NSString *dailyMemo = [selectedPic valueForKey:@"memo"];
    self.DailyTextView.text = dailyMemo;
    
    //カメラで取った写真 or メモがある場合にそのイベントに写真を紐づけるUserDefaultを作成
    if (selectedPicture || selectedMemo) {
        
        NSString *date = [selectedPic valueForKey:@"date"];
        NSString *title = [selectedPic valueForKey:@"title"];
        NSString *memo = [selectedPic valueForKey:@"memo"];
        
        NSNumber *eventId   = [NSNumber new];
        for (NSDictionary *dic in ary) {
            if ([[dic valueForKey:@"title"] isEqualToString:title]) {
                eventId = [dic valueForKey:@"id"];
            }
        }

        // 入力したいデータを辞書型にまとめる
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic = @{@"id": eventId, @"picture": selectedPicture, @"memo": memo, @"date":date}.mutableCopy;
        
        // 現状で保存されているデータ一覧を取得
        NSMutableArray *array = [[usrDefault objectForKey:@"dailyPictures"]mutableCopy];
        if ([array count] > 0) {
                [array addObject:dic];
                [usrDefault setObject:array forKey:@"dailyPictures"];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:dic, nil];
            [usrDefault setObject:array forKey:@"dailyPictures"];
        }
        [usrDefault synchronize];
    }

    [usrDefault removeObjectForKey:@"selectedPic"];


    //カメラで撮影したイメージ（セルの日付とマッチしたもの）を取り出す
    NSData *picData   = [NSData new];
    NSString *setMemo = [NSString new];
    for (NSDictionary *dic in cameraAry) {
        if ([[dic valueForKey:@"date"] isEqualToString:eventDaysArySet] && [[dic valueForKey:@"id"] isEqualToNumber:[selectedDic valueForKey:@"id"]]) {
            picData = [dic valueForKey:@"picture"];
            setMemo = [dic valueForKey:@"memo"];
        }
    }

    // NSData→UIImage変換
    UIImage *setPic = [UIImage imageWithData:picData];
    
    
    //画面上にセットするデータを作成
    NSLog(@"なに%@",eventDaysArySet);
    
//        int c;
//        NSInteger count = [eventDaysArySet count];
//        for (c =1; c < count; c++) {
//            self.DailyNumber.text =  [NSString stringWithFormat:@"Day:%d",c];
//        }
//
    
    self.DailyNumber.text =  [NSString stringWithFormat:@"%@",eventDaysArySet];;
    self.DailyPicture.image = setPic;
    self.DailyTextView.text = setMemo;
    
    
    //カメラで撮影された画像 をNSData→UIImageに変換 （セルで処理をする）
    UIImage *dailyPic = [UIImage imageWithData:selectedPicture];
    
    //セルの設定メソッドに送る情報　（撮影画像）
    self.DailyPicture.image = dailyPic;
    

}


- (void)objectsDesign{
    
    //TextViewを編集不可にする処理
    self.DailyTextView.editable = NO;
   
}

@end
