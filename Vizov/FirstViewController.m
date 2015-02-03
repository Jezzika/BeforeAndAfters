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
@property (nonatomic) NSMutableArray *challengesLater;

@property (nonatomic) NSTimer *timer;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Table ViewのデータソースにView Controller自身を設定する
    self.listTableView.dataSource = self;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *ary= [userDefault objectForKey:@"challenges"];
    
    //配列をfor文でまわす
    int myCountNow = 0;
    int myCountSuccess = 0;
    
    for (NSString *dic in ary) {
        if([[dic valueForKey:@"type"] isEqualToString:@"now"]){
            myCountNow++;
        }
    }
    
    for (NSString *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"success"]){
        myCountSuccess++;
     }
        
        //現在時刻の表示
        self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0)
                                                      target:self
                                                    selector:@selector(onTimer:)
                                                    userInfo:nil
                                                     repeats:YES];
        
    }
    
    //    self.nowEventCount.text = [NSString stringWithFormat:@"%d", myCountNow];
    
    //UIButtonの文字を変える！
    //    NSString *successButton = [NSString stringWithFormat:@"%d", myCountSuccess];
    //    [self.successEventCountButton setTitle:successButton forState:UIControlStateNormal];
    //    self.successEventCountButton.titleLabel.text = successButton;
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.allowsSelection = YES;
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // セクションタイトルの文字列変数を宣言
    NSString *title;
    
    // 表示しているセクションのタイトルを
    switch (section) {
        case 0:
            title = @"NOW";
            break;
        case 1:
            title = @"RESERVED";
            break;
        default:
            break;
    }
    
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Table Viewの行数を返す
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [userDefault objectForKey:@"challenges"];
    
    
//    NSMutableArray *challenges = [NSMutableArray new];
//    for (NSDictionary *dic in ary) {
//        if ([[dic valueForKey:@"type"] isEqualToString:@"now"] || [[dic valueForKey:@"type"] isEqualToString:@"yet"]) {
//            [challenges addObject:dic];
//        }
//    }
    
    NSMutableArray *challengesNow = [NSMutableArray new];
    NSMutableArray *challengesLater = [NSMutableArray new];
    for (NSDictionary *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"now"]) {
            [challengesNow addObject:dic];
        } else if ([[dic valueForKey:@"type"] isEqualToString:@"yet"]) {
            [challengesLater addObject:dic];
        }
    }
    
    NSInteger rows;
    
    switch (section) {
        case 0:
            rows = [challengesNow count];
            break;
        case 1:
            rows = [challengesLater count];
            break;
        default:
            break;
    }
    
    self.challengesNow = challengesNow;
    self.challengesLater = challengesLater;
    
    return rows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"ListView";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *items;
    switch (indexPath.section) {
        case 0:
            items = self.challengesNow[indexPath.row];
            break;
        case 1:
            items = self.challengesLater[indexPath.row];
            break;
        default:
            break;
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
        } else if (section == 1) {
            selectedArray = self.challengesLater[row];
        }
        
        //データを書き込む
        [myDefault setObject:selectedArray forKey:@"selectedAry"];
        [myDefault synchronize];
        NSLog(@"個数　%@",selectedArray);
        
        // 遷移先画面に一覧から来たというフラグを渡す
        PersonalPageViewController *personalView = [segue destinationViewController];
        personalView.fromFirstView = YES;
    }
    
    
    
    
}

@end

