//
//  PersonalPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/22/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "PersonalPageViewController.h"

@interface PersonalPageViewController ()

@end

@implementation PersonalPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    //UserDefaultの個別データ表示
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *ary1 = [[usrDefault objectForKey:@"challenges" ]valueForKeyPath:@"title"];
    NSString *lastTitle = [ary1 lastObject];
    
    NSMutableArray *ary2 = [[usrDefault objectForKey:@"challenges" ]valueForKeyPath:@"detail"];
    NSString *lastDeail = [ary2 lastObject];
    
    
    self.settedTitle.text = lastTitle;
    NSLog(@"%@",lastDeail);
    
    //現在時刻の表示
    NSDate *datetime = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy/MM/dd";
    NSString *resultDate = [fmt stringFromDate:datetime];  //表示するため文字列に変換する
    self.realTime.text = resultDate;
    
    fmt.dateFormat = @"HH:mm:ss";
    NSString *resultTime = [fmt stringFromDate:datetime];
    self.realTime2.text = resultTime;
    
    
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
