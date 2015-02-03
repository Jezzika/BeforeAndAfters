//
//  PersonalPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/22/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "PersonalPageViewController.h"
#import "PersonalTableViewCell.h"

@interface PersonalPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSDictionary * tableDict;

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
    NSString *timer;
    
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
    NSMutableArray *ary5;
    NSString *lastTimer;
    
    
    
    if (self.fromFirstView) {
        title = [[usrDefault objectForKey:@"selectedAry"]valueForKeyPath:@"title"];
        
        detail = [[usrDefault objectForKey:@"selectedAry" ]valueForKeyPath:@"detail"];
        
        pictData = [[usrDefault objectForKey:@"selectedAry" ]valueForKeyPath:@"picture"];
        
        // NSData→UIImage変換
        picture = [UIImage imageWithData:pictData];
        
        timer = [[usrDefault objectForKey:@"selectedAry"] valueForKey:@"timer"];
        
        self.settedTitle.text = title;
        self.settedBeforePicture.image = picture;
        self.settedTimer.text = timer;
        self.settedDetail.text = detail;
        
    } else if (self.fromNewPageView) {

        ary1 = [[usrDefault objectForKey:@"challenges"]valueForKeyPath:@"title"];
        lastTitle = [ary1 lastObject];
        
        ary2 = [[usrDefault objectForKey:@"challenges" ]valueForKeyPath:@"detail"];
        lastDetail = [ary2 lastObject];
        
        ary3 = [[usrDefault objectForKey:@"challenges" ]valueForKeyPath:@"picture"];
        lastPicturedata = [ary3 lastObject];
        
        // NSData→UIImage変換
        lastPicture = [UIImage imageWithData:lastPicturedata];
        
        ary4 =[[usrDefault objectForKey:@"challenges"] valueForKeyPath:@"type"];
        lastType = [ary4 lastObject];
        
        ary5 =[[usrDefault objectForKey:@"challenges"] valueForKeyPath:@"timer"];
        lastTimer = [ary5 lastObject];
        
        
        self.settedTitle.text = lastTitle;
        self.settedBeforePicture.image = lastPicture;
        self.settedTimer.text = lastTimer;
        self.settedDetail.text = lastDetail;
        
    }




        
    //現在時刻の表示
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0)
                                             target:self
                                           selector:@selector(onTimer:)
                                           userInfo:nil
                                            repeats:YES];
    
    self.listDetailTable.delegate = self;
    self.listDetailTable.dataSource = self;
    self.listDetailTable.allowsSelection = YES;
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Table Viewの行数を返す
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [userDefault objectForKey:@"selectedAry"];
    NSString *timer = [ary valueForKey:@"timer"];
    int num = [timer intValue];
    int number = num + 1;
    int i = 1;
    while (i < number) {
        i++;
    }
    NSLog(@"%d",i);
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"DailyList";
    PersonalTableViewCell *cell = [self.listDetailTable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefault objectForKey:@"selectedAry"];
    NSString *timer = [dict valueForKey:@"timer"];
    int num = [timer intValue];
    
    NSMutableArray *tableAry = [NSMutableArray array];
    int i=0;
    for (i=1; i<num+1; i++) {
        [tableAry addObject:[NSString stringWithFormat:@"%d",i]];
    }
    



    
    // カスタムセルにデータを渡して表示処理を委譲
    [cell setData:tableAry];
    
    self.tableDict = tableAry;
    
    
    return cell;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
