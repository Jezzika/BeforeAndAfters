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
@property (nonatomic) NSMutableArray *challengesNow;

@property (nonatomic) NSTimer *timer;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

        //現在時刻の表示
        self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0)
                                                      target:self
                                                    selector:@selector(onTimer:)
                                                    userInfo:nil
                                                     repeats:YES];
        
        
        
        // Table ViewのデータソースにView Controller自身を設定する
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        self.listTableView.allowsSelection = YES;
    
    
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSArray *picary = [usr objectForKey:@"dailyPictures"];
    
//    NSLog(@"いまのけんきゅう1%@",picary);
    NSLog(@"いまのけんきゅう2%lu",[picary count]);



}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //自前でハイライト解除
    [self.listTableView deselectRowAtIndexPath:[self.listTableView indexPathForSelectedRow] animated:animated];
}


-(void)onTimer:(NSTimer*)timer {
    
        //現在時刻取得
        NSDate* now = [NSDate date];
        
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ary = [usr objectForKey:@"challenges"];
        
        if (!ary){
            return 0;
        } else {
            return 1;
        }
// Return the number of sections.
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
        // セクションタイトルの文字列変数を宣言
        NSString *title;
        
        // 表示しているセクションのタイトル
        if (section == 0) {
                title = @"NOW";
        }
        return title;
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
        
        if (section == 0){
                    rows = [challengesNow count];
        }
    
        self.challengesNow   = challengesNow;
        
        return rows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        //セルの名前をつける
        //StorybordのprototypeのセルのIdentifierで設定しないとエラーになる
        static NSString *CellIdentifier = @"ListView";
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }

        NSDictionary *items;
        if (indexPath.section == 0) {
            items = self.challengesNow[indexPath.row];
        }


        // カスタムセルにデータを渡して表示処理を委譲
        [cell setData:items];

        return cell;

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self performSegueWithIdentifier:@"toPersonalPage" sender:indexPath];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toPersonalPage"]){
            NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
    //        NSIndexPath *indexPath = self.listTableView.indexPathForSelectedRow;

            NSInteger section = [sender section];
            NSInteger row = [sender row];
            NSArray *selectedArray;
        
            if (section == 0) {
                selectedArray = self.challengesNow[row];
            }
            //データを書き込む selectedAry はactually Dictionaryです
            [myDefault setObject:selectedArray forKey:@"selectedAry"];
            [myDefault synchronize];

            // 遷移先画面(PersonalPageView)に一覧から来たというフラグを渡す
            PersonalPageViewController *personalView = [segue destinationViewController];
            personalView.fromFirstView = YES;
        }
    
    
    
    
}

@end

