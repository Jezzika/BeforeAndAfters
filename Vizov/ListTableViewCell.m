//
//  ListTableViewCell.m
//  Vizov
//
//  Created by MiriKunisada on 2/6/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)doneItems{

    //タイトル
    self.titleLabel.text = [NSString stringWithFormat:@"%@DAYS %@",[doneItems valueForKey:@"timer"],[doneItems valueForKeyPath:@"title"]];
    
    //Before写真のイメージ
    NSData *pictData = [doneItems valueForKeyPath:@"picture"];
    // NSData→UIImage変換
    UIImage *picture = [UIImage imageWithData:pictData];
    self.beforeImage.image = picture;
    
    //After写真のイメージ（カメラ撮影でとった写真のデータを取得）
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *cameraAry  = [usrDefault objectForKey:@"dailyPictures"];
    
    NSNumber *setId  = [doneItems valueForKey:@"id"];
    
    //カメラで撮影したイメージ（セルの日付とマッチしたもの）を取り出す
    NSMutableArray *setAry = [NSMutableArray array];
    for (NSDictionary *dic in cameraAry) {
        if ([[dic valueForKey:@"id"]isEqualToNumber:setId]){
            [setAry addObject:dic];
        }
    }
        
    // NSData→UIImage変換
    UIImage *setPic;
    setPic = [UIImage imageWithData:[[setAry valueForKey:@"picture"]lastObject]];
    
    //データのセット
    self.afterImage.image = setPic;
    
        
    
    
    
    //デザイン
    //BEFOREラベル/Image
    self.beforeLabel.backgroundColor = [UIColor peterRiverColor];
    self.beforeLabel.layer.cornerRadius = 3;
    self.beforeLabel.clipsToBounds = true;

    self.beforeImage.layer.cornerRadius = 3;
    self.beforeImage.clipsToBounds = true;
    
    //AFTERラベル/Image
    self.afterLabel.backgroundColor = [UIColor alizarinColor];
    self.afterLabel.layer.cornerRadius = 3;
    self.afterLabel.clipsToBounds = true;
    
    self.afterImage.layer.cornerRadius = 3;
    self.afterImage.clipsToBounds = true;
    
    //Title
    self.titleLabel.backgroundColor = [UIColor cloudsColor];
    self.titleLabel.textColor = [UIColor midnightBlueColor];
    
    //totalDays
    self.totalDays.backgroundColor = [UIColor cloudsColor];
    self.totalDays.textColor = [UIColor midnightBlueColor];
    
}


@end
