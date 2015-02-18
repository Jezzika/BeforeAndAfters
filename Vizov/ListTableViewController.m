//
//  ListTableViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/26/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListTableViewCell.h"
#import "MyEventsTableViewController.h"

@interface ListTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic) NSMutableArray *now;
@property(nonatomic) NSMutableArray *doneChallenges;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [usrDefault objectForKey:@"selectedSuccessAry"];
    
    NSIndexPath *indexPath = self.listTableView.indexPathForSelectedRow;
    NSArray *selectedArray = ary[indexPath.row];
    
    
    //UserDefaultの個別データ表示(ホームの一覧リストから）
    NSArray *title;
    NSArray *detail;
    NSData *pictData;
    UIImage *picture;
    
    
    
    if (self.fromFirstView) {
        title = [selectedArray valueForKeyPath:@"title"];
        
        detail = [selectedArray valueForKeyPath:@"detail"];
        
        pictData = [selectedArray valueForKeyPath:@"picture"];
        
        // NSData→UIImage変換
        picture = [UIImage imageWithData:pictData];
        
    }
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.allowsSelection = YES;
    
    //デザイン用のメソッドを作成
    [self objectsDesign];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(void)viewWillAppear:(BOOL)animated {
    
    //自前でハイライト解除
    [self.listTableView deselectRowAtIndexPath:[self.listTableView indexPathForSelectedRow] animated:animated];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [usr objectForKey:@"challenges"];
    
    NSMutableArray *challengesDone = [NSMutableArray new];
    for (NSDictionary *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"success"]||[[dic valueForKey:@"type"] isEqualToString:@"failure"]) {
            [challengesDone addObject:dic];
        }
    }
    
    self.doneChallenges = challengesDone;
    
    NSInteger rows;
    
    if ([challengesDone count] > 0) {
        rows = [challengesDone count];
    } else {
        rows = 0;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"Cell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [usr objectForKey:@"challenges"];
    
    NSMutableArray *challengesDone = [NSMutableArray new];
    for (NSDictionary *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"success"]||[[dic valueForKey:@"type"] isEqualToString:@"failure"]) {
            [challengesDone addObject:dic];
        }
    }
    
    NSMutableArray *doneItems = challengesDone[indexPath.row];

    
    [cell setData:doneItems];
    
    [cell configureFlatCellWithColor:[UIColor whiteColor]
                       selectedColor:[UIColor cloudsColor]];
    
    cell.cornerRadius = 5.0f; // optional
    cell.separatorHeight = 2.0f; // optional

    cell.layer.borderWidth =4;
    cell.layer.borderColor = [UIColor cloudsColor].CGColor;

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"toMyEvents"]){
        NSUserDefaults *myDefault = [NSUserDefaults standardUserDefaults];
        NSIndexPath *indexPath = self.listTableView.indexPathForSelectedRow;
        
        NSMutableDictionary *selectedDic;
        
        selectedDic = self.doneChallenges[indexPath.row];
            
        //データを書き込む
        [myDefault setObject:selectedDic forKey:@"selectedDic2"];
        [myDefault synchronize];
        
        // 遷移先画面(PersonalPageView)に一覧から来たというフラグを渡す
        MyEventsTableViewController *personalView = [segue destinationViewController];
        personalView.fromListView = YES;
    }

}

- (void)objectsDesign{
    
    // tableviewの境界線の色
    self.listTableView.separatorColor = [UIColor cloudsColor];
    
    // NavBarデザイン
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor turquoiseColor]];
    
    
}

- (IBAction)deleteItemBtn:(id)sender {
    
     [self.listTableView setEditing:!self.listTableView.editing animated:YES];
    
}

//削除ボタンの実装メソッド
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [[usr objectForKey:@"challenges"]mutableCopy];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //該当するデータを削除する
        [ary removeObject:self.doneChallenges[indexPath.row]];
        [usr setObject:ary forKey:@"challenges"];
        [usr synchronize];
        
        //テーブルから行を削除
        [self.listTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else {
        
    }

}


@end
