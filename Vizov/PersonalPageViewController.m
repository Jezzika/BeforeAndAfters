//
//  PersonalPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/22/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "PersonalPageViewController.h"
#import "PersonalTableViewCell.h"

@interface PersonalPageViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

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

        NSDictionary *dic = [usrDefault objectForKey:@"selectedDic"];
        
        title = [dic valueForKeyPath:@"title"];
        detail = [dic valueForKeyPath:@"detail"];
        pictData = [dic valueForKeyPath:@"picture"];
        
        // NSData→UIImage変換
        picture = [UIImage imageWithData:pictData];
        NSString *finDate = [dic valueForKey:@"finDate"];
        
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
        
        
    } else {
        //elseということでこのページにくるもう一方のデータ（fromCameraView)と認識させる
        
        //カメラで撮影された画像 UserDefault
        NSMutableArray *selectedPic = [usrDefault objectForKey:@"selectedPic"];
        NSString *selectedPicTitle = [selectedPic valueForKey:@"title"];
        
        //全データ UserDefault
        NSMutableArray *ary = [usrDefault objectForKey:@"challenges"];
        
        NSMutableArray *challengesEqual = [NSMutableArray new];
        for (NSDictionary *dic in ary) {
            if ([[dic valueForKey:@"title"] isEqualToString:selectedPicTitle]) {
                [challengesEqual addObject:dic];
            }
        
        }
    
        //マッチしたchallengeのデータ（これを使います！）
        NSMutableArray *challengesEqualLast = [challengesEqual lastObject];
        
        //---title と　detail と countdownのデータはいつも通り---
        title2 = [challengesEqualLast valueForKeyPath:@"title"];
        detail2 = [challengesEqualLast valueForKeyPath:@"detail"];
        
        NSString *finDate = [challengesEqualLast valueForKey:@"finDate"];
        
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
        
        self.settedTitle.text = title2;
        self.settedDetail.text = detail2;
        
        //--カメラ撮影での処理なので--
        //セルで処理
        
        //デザイン用のメソッドを作成
        [self objectsDesign];
        
    }

    self.listDetailTable.delegate = self;
    self.listDetailTable.dataSource = self;
    self.listDetailTable.allowsSelection = YES;
    
    //TextViewを編集不可にする処理
    self.settedDetail.editable = NO;
    
    //背景viewの色を変更
    self.view.backgroundColor = [UIColor sunflowerColor];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //自前でハイライト解除
    [self.listDetailTable deselectRowAtIndexPath:[self.listDetailTable indexPathForSelectedRow] animated:animated];
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
    NSMutableArray *ary = [userDefault objectForKey:@"selectedDic"];

    NSString *timer = [ary valueForKey:@"timer"];
    int num = [timer intValue];
    int number = num ;
    int i = 1;
    while (i < number) {
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
    NSDictionary *dict = [userDefault objectForKey:@"selectedDic"];
    NSString *timer = [dict valueForKey:@"timer"];
    
    int num = [timer intValue];

    // 日付のオフセットを生成(次の日をとってくる)
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    
    // x日後とする
    int x;

    // x日後のNSDateインスタンスを取得する
    //初期化
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //日付のフォーマット指定
    df.dateFormat = @"yyyy/MM/dd";

    NSDate *date = [NSDate date];
    NSString *result = [NSString string];

    NSMutableArray *eventDaysAry = [NSMutableArray array];
    for (x=0; x<num; x++) {
        
        [dateComp setDay:x];
        date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComp toDate:[NSDate date] options:0];
        result = [df stringFromDate:date];
        [eventDaysAry addObject:result];
        
    }

    NSMutableArray *eventDaysArySet = eventDaysAry[indexPath.row];

    //カスタムセルにデータを渡して表示処理を委譲
    [cell setData:eventDaysArySet];
    
    [cell configureFlatCellWithColor:[UIColor whiteColor]
                       selectedColor:[UIColor cloudsColor]];
    
    cell.cornerRadius = 5; // optional
 
    
    // tableviewの境界線の色
    self.listDetailTable.separatorColor = [UIColor whiteColor];

    return cell;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)objectsDesign{
    

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toCamera"]){

    NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic =[myDefault objectForKey:@"selectedDic"];
        

    NSLog(@"みてみる！%@", dic);

    //データを書き込む
    [myDefault setObject:dic forKey:@"selectedDic"];
    [myDefault synchronize];


    }
}


@end
