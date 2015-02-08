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
    

        NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ary        = [usrDefault objectForKey:@"challenges"];
        NSMutableArray *cameraAry  = [usrDefault objectForKey:@"dailyPictures"];
        NSMutableArray *selectedAry = [usrDefault objectForKey:@"selectedAry"];

        //カメラで撮影された画像 UserDefault
        NSMutableArray *selectedPic = [usrDefault objectForKey:@"selectedPic"];
        NSData *selectedPicture = [selectedPic valueForKey:@"picture"];

        //カメラで撮影された画像 をNSData→UIImageに変換 （セルで処理をする）
        UIImage *dailyPic = [UIImage imageWithData:selectedPicture];

        //セルの設定メソッドに送る情報　（撮影画像）
        self.DailyPicture.image = dailyPic;

        //カメラで取った写真がある場合にそのイベントに写真を紐づけるUserDefaultを作成
        if (selectedPicture) {
            
            NSString *date = [selectedPic valueForKey:@"date"];
            NSString *title = [selectedPic valueForKey:@"title"];
            
            NSNumber *eventId   = [NSNumber new];
            for (NSDictionary *dic in ary) {
                if ([[dic valueForKey:@"title"] isEqualToString:title]) {
                    eventId = [dic valueForKey:@"id"];
                }
            }
            
            // 入力したいデータを辞書型にまとめる
            NSMutableDictionary *dic = @{@"id": eventId, @"picture": selectedPicture, @"date":date}.mutableCopy;
            
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

        self.DailyNumber.text =  [NSString stringWithFormat:@"%@",eventDaysArySet];

        //カメラで撮影したイメージ（セルの日付とマッチしたもの）を取り出す
        NSData *picData   = [NSData new];
        for (NSDictionary *dic in cameraAry) {
            if ([[dic valueForKey:@"date"] isEqualToString:eventDaysArySet] && [[dic valueForKey:@"id"] isEqualToNumber:[selectedAry valueForKey:@"id"]]) {
                picData = [dic valueForKey:@"picture"];
            }
        }

        // NSData→UIImage変換
        UIImage *setPic = [UIImage imageWithData:picData];

        self.DailyPicture.image = setPic;
    

}






@end
