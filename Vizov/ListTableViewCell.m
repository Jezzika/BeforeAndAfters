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
    self.titleLabel.text = [NSString stringWithFormat:@"%@ : %@",[doneItems valueForKey:@"timer"],[doneItems valueForKeyPath:@"title"]];
    
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
    
    //-----------------デザイン----------------------
    //BEFOREラベル
    self.beforeLabel.textColor = [UIColor midnightBlueColor];
    self.beforeImage.layer.borderColor = [UIColor turquoiseColor].CGColor;
    self.beforeImage.layer.borderWidth = 3;
    
    //BeforeView
    self.beforeView.backgroundColor = [UIColor whiteColor];
    self.beforeView.layer.borderColor = [UIColor cloudsColor].CGColor;
    self.beforeView.layer.borderWidth = 3;
    
    
    
    //AFTERラベル
    self.afterLabel.textColor = [UIColor midnightBlueColor];
    self.afterImage.layer.borderColor = [UIColor turquoiseColor].CGColor;
    self.afterImage.layer.borderWidth = 3;
    
    //AfterView
    self.afterView.backgroundColor = [UIColor whiteColor];
    self.afterView.layer.borderColor = [UIColor cloudsColor].CGColor;
    self.afterView.layer.borderWidth = 3;

    
    //Title
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    self.titleLabel.textColor = [UIColor turquoiseColor];
    self.titleLabel.layer.borderWidth = 2;
    self.titleLabel.layer.borderColor = [UIColor cloudsColor].CGColor;
    
    //totalDays
    self.totalDays.backgroundColor = [UIColor cloudsColor];
    self.totalDays.textColor = [UIColor midnightBlueColor];
    
}


@end
