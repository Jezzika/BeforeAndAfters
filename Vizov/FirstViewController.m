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

@interface FirstViewController ()<UITableViewDataSource>

@property (nonatomic) NSString * cell2;
@property (nonatomic) NSArray * tableArray;


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
    int myCount = 0;
    for (NSString *now in ary) {
        if([[now valueForKey:@"type"] isEqualToString:@"now"]){
            myCount++;
        }
        
    }

    NSLog(@"%@",ary);

    self.nowEventCount.text = [NSString stringWithFormat:@"%d", myCount];
    
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
    return [ary count];
    //return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [userDefault objectForKey:@"challenges"];
    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"ListView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *label1 =(UILabel *)[cell viewWithTag:1];
    label1.text = [NSString stringWithFormat:@"%ld",indexPath.row];

    
    //セルに ary を番号順に突っ込む
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:indexPath.row]valueForKeyPath:@"title"]];
    
    
    //cellの番号をcell2にいれる（segueメソッド用）
    self.cell2 = label1.text;
    
    self.tableArray = ary;
    
    return cell;

//    if (tvcell == nil) {
//        tvcell = [[UITable    ViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                        reuseIdentifier: @"cid"];
//    }
//    
//    // Table Viewの各行の情報を、UITableViewCellのオブジェクトとして返す
//    tvcell.textLabel.text = [[NSString alloc] initWithFormat:@"%ld行目のセル", indexPath.row + 1];
//    return tvcell;

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
        NSArray *selectedArray = self.tableArray[indexPath.row];

        //データを書き込む
        [myDefault setObject:selectedArray forKey:@"selectedAry"];
        [myDefault synchronize];
        NSLog(@"%@",selectedArray);
        
        // 遷移先画面に一覧から来たというフラグを渡す
        PersonalPageViewController *personalView = [segue destinationViewController];
        personalView.fromFirstView = YES;
    }
}

@end

