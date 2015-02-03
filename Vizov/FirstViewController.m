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
@property (nonatomic) NSMutableArray *challenges;

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
    }

    self.nowEventCount.text = [NSString stringWithFormat:@"%d", myCountNow];
    
    //UIButtonの文字を変える！
    NSString *successButton = [NSString stringWithFormat:@"%d", myCountSuccess];
    [self.successEventCountButton setTitle:successButton forState:UIControlStateNormal];
    self.successEventCountButton.titleLabel.text = successButton;
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.allowsSelection = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Table Viewの行数を返す
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [userDefault objectForKey:@"challenges"];

    
    NSMutableArray *challenges = [NSMutableArray new];
    for (NSDictionary *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"now"] || [[dic valueForKey:@"type"] isEqualToString:@"yet"]) {
            [challenges addObject:dic];
        }
    }
    self.challenges = challenges;
    
    return [challenges count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *homeEventLabel = self.challenges[indexPath.row];
    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"ListView";
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // カスタムセルにデータを渡して表示処理を委譲
    [cell setData:homeEventLabel];

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toPersonalPage"]){
        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        NSIndexPath *indexPath = self.listTableView.indexPathForSelectedRow;
        NSArray *selectedArray = self.challenges[indexPath.row];

        //データを書き込む
        [myDefault setObject:selectedArray forKey:@"selectedAry"];
        [myDefault synchronize];
        NSLog(@"個数　%@",selectedArray);
        
        // 遷移先画面に一覧から来たというフラグを渡す
        PersonalPageViewController *personalView = [segue destinationViewController];
        personalView.fromFirstView = YES;
    }
    
    if ([[segue identifier] isEqualToString:@"successSegue"]){
        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ary= [myDefault objectForKey:@"challenges"];
        
        for (NSDictionary *dic in ary) {
            if([[dic valueForKey:@"type"] isEqualToString:@"success"]){
                NSMutableArray *nowAry = [[NSMutableArray alloc] initWithObjects:dic, nil];
                [myDefault setObject:nowAry forKey:@"selectedSuccessAry"];
            }
            
        //データを書き込む
        [myDefault synchronize];
        
        // 遷移先画面に一覧から来たというフラグを渡す
        ListTableViewController *listTableView = [segue destinationViewController];
        listTableView.fromFirstView = YES;

        }
    }
}

@end

