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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(didTapEditButton)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor turquoiseColor];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor cloudsColor]
                                  highlightedColor:[UIColor greenSeaColor]
                                      cornerRadius:3];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //自前でハイライト解除
    [self.listTableView deselectRowAtIndexPath:[self.listTableView indexPathForSelectedRow] animated:animated];
    
    //デザインのメソッドを作成
    [self objectsDesign];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)didTapEditButton
{
    [self.listTableView setEditing:!self.listTableView.editing animated:YES];
    if (self.listTableView.editing) {
        self.navigationItem.rightBarButtonItem.title = @"Cancel";
    } else {
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    }
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
    
        //セルの名前をつける
        //StorybordのprototypeのセルのIdentifierで設定しないとエラーになる
        static NSString *CellIdentifier = @"ListView";
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }

        NSDictionary *items;
    
        items = self.challengesNow[indexPath.row];
    


        // カスタムセルにデータを渡して表示処理を委譲
        [cell setData:items];
    

        [cell configureFlatCellWithColor:[UIColor turquoiseColor]
                           selectedColor:[UIColor cloudsColor]];

        cell.cornerRadius = 5.0f; // optional
        cell.separatorHeight = 2.0f; // optional


        return cell;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self performSegueWithIdentifier:@"toPersonalPage" sender:indexPath];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [[usr objectForKey:@"challenges"]mutableCopy];
    
    NSLog(@"する前%lu",(unsigned long)[ary count]);
    NSLog(@"する前%@",ary);
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
  
        // Delete the row from the data source
        NSInteger row = [indexPath row];
        [self.challengesNow removeObjectAtIndex: row];
//
//        [tableView deleteRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
    }
    
    NSLog(@"した後%lu",(unsigned long)[ary count]);
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
    
    // BarBtnFlat化
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor turquoiseColor]
                                  highlightedColor:[UIColor greenSeaColor]
                                      cornerRadius:3];
    

    
    // NavBarデザイン
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor cloudsColor]];
    
    
    // tableviewの境界線の色
    self.listTableView.separatorColor = [UIColor whiteColor];
    

    
    

}

@end

