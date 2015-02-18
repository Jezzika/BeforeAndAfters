//
//  FirstViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "FirstViewController.h"
#import "NewPageViewController.h"
#import "PersonalPageViewController.h"
#import "ListTableViewController.h"
#import "FirstTableViewCell.h"

@interface FirstViewController ()<UITableViewDataSource>

@property (nonatomic) NSArray * tableArray;
@property (nonatomic) NSMutableArray * timerAscArray;
@property (nonatomic) NSTimer *timer;



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Table ViewのデータソースにView Controller自身を設定する
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.allowsSelection = YES;

    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    //NOWのチャレンジを配列に格納
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [usr objectForKey:@"challenges"];
    NSMutableArray *challengesNow   = [NSMutableArray new];
    
    for (NSDictionary *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"now"]) {
            [challengesNow addObject:dic];
        }
    }
    
    //Notificationの設定　Nowのイベントが存在する時のみに通知を行う
    if (challengesNow) {
        
        //インスタンス化(ローカル通知を作成）
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        if (localNotification == nil){
        return;
        }

        // NSDateFormatter を用意します。
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        // 変換用の書式を設定
        [formatter setDateFormat:@"HH:mm"];


        //-------- localNotificationの設定 -------------------
        //全ての通知をキャンセル
        [[UIApplication sharedApplication] cancelAllLocalNotifications];

        //通知時間生成
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *today = [NSDate date];//今日

        //通知を受ける時刻を指定
        NSDate *date;
        NSDateComponents *componentsForFireDate;
        NSDateComponents *componentsForFireDate2;

        date = [today dateByAddingTimeInterval: 24 * 60 * 60];
        componentsForFireDate = [calendar components:(NSCalendarUnitYear  |
                                                  NSCalendarUnitMonth |
                                                  NSCalendarUnitDay   |
                                                  NSCalendarUnitWeekday)
                                        fromDate:date];

        componentsForFireDate2 = [calendar components:(NSCalendarUnitYear  |
                                                  NSCalendarUnitMonth |
                                                  NSCalendarUnitDay   |
                                                  NSCalendarUnitWeekday)
                                        fromDate:date];
        //12:00を指定
        [componentsForFireDate setHour:12];
        [componentsForFireDate setMinute:0] ;
        [componentsForFireDate setSecond:0] ;
        //18:00を指定
        [componentsForFireDate2 setHour:18];
        [componentsForFireDate2 setMinute:0] ;
        [componentsForFireDate2 setSecond:0] ;
        NSDate *fireDateOfNotification = [calendar dateFromComponents: componentsForFireDate];
        NSDate *fireDateOfNotification2 = [calendar dateFromComponents: componentsForFireDate2];

        localNotification.fireDate = fireDateOfNotification;
        localNotification.fireDate = fireDateOfNotification2;

        //通知メッセージの本文(チャレンジのタイトル)
        localNotification.alertBody = @"You have a challenge!";
        //アイコンバッチの数字
        localNotification.applicationIconBadgeNumber = 1;

        //通知メッセージアラートのボタンに表示される文字を指定
        localNotification.alertAction = @"Open";

        // 効果音は標準の効果音を利用する(バイブも）
        localNotification.soundName = UILocalNotificationDefaultSoundName;

        // タイムゾーンを指定する
        localNotification.timeZone = [NSTimeZone defaultTimeZone];

        // 毎日繰り返す
        localNotification.repeatInterval = NSCalendarUnitDay;

        //作成した通知イベント情報をアプリケーションに登録
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

        //-------- localNotification End ----------------------
    } else {

        //バッチを0にするよ〜
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

        //このアプリ名義で登録しているローカル通知を削除するよ〜
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
    }


}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    NSLog(@"-----");
//    NSLog(@"%@", [[UIApplication sharedApplication] scheduledLocalNotifications]);
//    if ([[[UIApplication sharedApplication] scheduledLocalNotifications] count] > 0) {
//        NSLog(@"%@", [[UIApplication sharedApplication] scheduledLocalNotifications][0]);
//    }
//    
//    NSLog(@"-----");
    
    
    //自前でハイライト解除
    [self.listTableView deselectRowAtIndexPath:[self.listTableView indexPathForSelectedRow] animated:animated];
    
    // tableviewの境界線の色
    self.listTableView.separatorColor = [UIColor clearColor];
    // NavBarデザイン
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor turquoiseColor]];
    
        
}

- (void)viewDidDisappear:(BOOL)animated {
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Table Viewの行数を返す
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [userDefault objectForKey:@"challenges"];
    
    //NOWのチャレンジを配列に格納
    NSMutableArray *challengesNow   = [NSMutableArray new];
    for (NSDictionary *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"now"]) {
            [challengesNow addObject:dic];
        }
    } 
    
    NSInteger rows;
    rows = [challengesNow count];
    self.challengesNow   = challengesNow;
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //セルの名前をつける　StorybordのprototypeのセルのIdentifierで設定しないとエラーになる
    static NSString *CellIdentifier = @"ListView";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }

    NSDictionary *items;
    items = self.challengesNow[indexPath.row];

    // カスタムセルにデータを渡して表示処理を委譲
    [cell setData:items];

    //セルのデザイン
    [cell configureFlatCellWithColor:[UIColor whiteColor]
                       selectedColor:[UIColor cloudsColor]];

    cell.layer.borderWidth =2;
    cell.layer.borderColor = [UIColor cloudsColor].CGColor;
    cell.cornerRadius = 5.0f; // optional
    cell.separatorHeight = 2.0f; // optional
        
    return cell;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toPersonalPage" sender:indexPath];
}

//削除ボタンの実装メソッド
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [[usr objectForKey:@"challenges"]mutableCopy];

    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //該当するデータを削除する
        [ary removeObject:self.challengesNow[indexPath.row]];
        [usr setObject:ary forKey:@"challenges"];
        [usr synchronize];
        
        //テーブルから行を削除
        [self.listTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES; //行の並べ替えを可に
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toPersonalPage"]){
        
        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        NSInteger row = [sender row];
        NSDictionary *selectedDic;
        selectedDic = self.challengesNow[row];

        //データを書き込む
        [myDefault setObject:selectedDic forKey:@"selectedDic"];
        [myDefault synchronize];

        // 遷移先画面(PersonalPageView)に一覧から来たというフラグを渡す
        PersonalPageViewController *personalView = [segue destinationViewController];
        personalView.fromFirstView = YES;
    }
}

- (void)objectsDesign{
    
    // NavBarデザイン
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor turquoiseColor]];
    
    // tableviewの境界線の色
    self.listTableView.separatorColor = [UIColor clearColor];
    

}

- (IBAction)deleteItemBtn:(id)sender {
    
    [self.listTableView setEditing:!self.listTableView.editing animated:YES];
    
}
@end

