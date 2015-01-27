//
//  PersonalPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/22/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "PersonalPageViewController.h"

@interface PersonalPageViewController ()

@property (nonatomic) NSTimer *timer;

@end

@implementation PersonalPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view

    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];

    
    //UserDefaultの個別データ表示(ホームの一覧リストから）
    NSString *title;
    NSString *detail;
    NSData *pictData;
    UIImage *picture;
    
    //UserDefaultの個別データ表示(新規作成ページから）
    NSMutableArray *ary1;
    NSString *lastTitle;
    NSMutableArray *ary2;
    NSString *lastDetail;
    NSMutableArray *ary3;
    NSData *lastPicturedata;
    UIImage *lastPicture;
    NSMutableArray *ary4;
    NSString *lastType;
    
    
    
    if (self.fromFirstView) {
        title = [[usrDefault objectForKey:@"selectedAry"]valueForKeyPath:@"title"];
        
        detail = [[usrDefault objectForKey:@"selectedAry" ]valueForKeyPath:@"detail"];
        
        pictData = [[usrDefault objectForKey:@"selectedAry" ]valueForKeyPath:@"picture"];
        
        // NSData→UIImage変換
        picture = [UIImage imageWithData:pictData];
        
        self.settedTitle.text = title;
        self.settedBeforePicture.image = picture;
        NSLog(@"%@",title);
        
    } else if (self.fromNewPageView) {

        ary1 = [[usrDefault objectForKey:@"challenges"]valueForKeyPath:@"title"];
        lastTitle = [ary1 lastObject];
        
        ary2 = [[usrDefault objectForKey:@"challenges" ]valueForKeyPath:@"detail"];
        lastDetail = [ary2 lastObject];
        
        ary3 = [[usrDefault objectForKey:@"challenges" ]valueForKeyPath:@"picture"];
        lastPicturedata = [ary3 lastObject];
        
        // NSData→UIImage変換
        lastPicture = [UIImage imageWithData:lastPicturedata];
        
        ary4 =[[usrDefault objectForKey:@"chakkenges"] valueForKeyPath:@"type"];
        lastType = [ary4 lastObject];
        
        self.settedTitle.text = lastTitle;
        self.settedBeforePicture.image = lastPicture;
        NSLog(@"%@",lastType);
        
    }




        
    //現在時刻の表示
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0)
                                             target:self
                                           selector:@selector(onTimer:)
                                           userInfo:nil
                                            repeats:YES];
    
}

-(void)onTimer:(NSTimer*)timer {
    NSDate* now = [NSDate date];//現在時刻取得
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateCamponents = [calendar components:NSCalendarUnitYear |
                                        NSCalendarUnitMonth  |
                                        NSCalendarUnitDay    |
                                        NSCalendarUnitHour   |
                                        NSCalendarUnitMinute |
                                        NSCalendarUnitSecond
                                                   fromDate:now];
  
    self.realTime.text = [NSString stringWithFormat:@"%ld/ %02ld/ %02ld",
                          (long)dateCamponents.year,
                          (long)dateCamponents.month,
                          (long)dateCamponents.day];
    
    self.realTime2.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",
                          (long)dateCamponents.hour,
                          (long)dateCamponents.minute,
                          (long)          dateCamponents.second];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
