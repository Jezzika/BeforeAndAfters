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
    
    //UserDefaultの個別データ表示(カメラ撮影ページから）
    NSString *title2;
    NSString *detail2;
    NSData *pictData2;
    UIImage *picture2;
    
    
    
    if (self.fromFirstView) {
        title = [[usrDefault objectForKey:@"selectedAry"]valueForKeyPath:@"title"];
        
        detail = [[usrDefault objectForKey:@"selectedAry" ]valueForKeyPath:@"detail"];
        
        pictData = [[usrDefault objectForKey:@"selectedAry" ]valueForKeyPath:@"picture"];
        
        // NSData→UIImage変換
        picture = [UIImage imageWithData:pictData];
        
        NSString *finDate = [[usrDefault objectForKey:@"selectedAry"] valueForKey:@"finDate"];
        
        //初期化(カウントダウン用のデータ作成）
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日付のフォーマット指定
        df.dateFormat = @"yyyy/MM/dd";
        
        NSDate *today = [NSDate date];
        
        // 日付(NSDate) => 文字列(NSString)に変換
        NSString *strNow = [df stringFromDate:today];
        NSDate *currentDate= [df dateFromString:strNow];
        
        NSDate *setFinDate = [df dateFromString:finDate];
        
        // dateBとdateAの時間の間隔を取得(dateA - dateBなイメージ)
        NSTimeInterval  since = [setFinDate timeIntervalSinceDate:currentDate];
        int mySince = (int) since/(24*60*60);
        if (mySince > 0){
            self.settedTimer.text = [NSString stringWithFormat:@"%d",mySince];
        } else {
        }

        
        self.settedTitle.text = title;
        self.settedBeforePicture.image = picture;
        self.settedDetail.text = detail;
        
        
    } else { //elseということでこのページにくるもう一方のデータ（fromCameraView)と認識させる
        
        //カメラで撮影された画像 UserDefault
        NSMutableArray * selectedPic = [usrDefault objectForKey:@"selectedPic"];
        NSString * selectedPicTitle = [[selectedPic valueForKey:@"title"]lastObject];
        
        //全データ UserDefault
        NSMutableArray * ary = [usrDefault objectForKey:@"challenges"];
        
        NSMutableArray *challengesEqual = [NSMutableArray new];
        for (NSDictionary *dic in ary) {
            if ([[dic valueForKey:@"title"] isEqualToString:selectedPicTitle]) {
                [challengesEqual addObject:dic];
            }
            NSLog (@"これってどうなの？%@",challengesEqual);
        
        }
        
        //マッチしたchallengeのデータ（これを使います！）
        NSMutableArray *challengesEqualLast = [challengesEqual lastObject];
        
        //title と　detail と countdownのデータはいつも通り
        title2 = [challengesEqualLast valueForKeyPath:@"title"];
        detail2 = [challengesEqualLast valueForKeyPath:@"detail"];
        
        self.settedTitle.text = title2;
        self.settedDetail.text = detail2;
        
    }

    self.listDetailTable.delegate = self;
    self.listDetailTable.dataSource = self;
    self.listDetailTable.allowsSelection = YES;
    

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
    int i = 1;
    while (i < num) {
        i++;
    }
    
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"DailyList";
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (cell == nil) {
        cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefault objectForKey:@"selectedAry"];
    NSString *timer = [dict valueForKey:@"timer"];
    NSString *startDate = [dict valueForKey:@"startDate"];
    
    //NSStringをNSDate型に変換
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //タイムゾーンの指定
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDate *startDate2 = [formatter dateFromString:startDate];
    
    int num = [timer intValue];
    
    NSMutableArray *timerAry = [NSMutableArray array];
    int i;
    for (i=1; i<num; i++) {
        [timerAry addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    ///timerAryの数だけまわす
    int challengeDaysCount = [timerAry count];

    NSMutableArray *days = [NSMutableArray new];

    for (i = 0; i > challengeDaysCount ; i++) {
        
        // 日付のオフセットを生成
        NSDateComponents *dateComp = [[NSDateComponents alloc] init];
        
        // i日後とする
        [dateComp setDay:i];
        
        // i日後のNSDateインスタンスを取得する
        NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
        
        [days addObject:date];
     
    }
    
    NSLog(@"みりあれい%@",days);
    NSLog(@"みりかうんと%d",[days count]);
    
    
//            [dateComp release];
    
    

    
    



    //カスタムセルにデータを渡して表示処理を委譲

//    [cell setData:tableAry];
//    
//    NSLog(@"てーぶるあれい%@",tableAry);

    return cell;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
