//
//  FirstViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "FirstViewController.h"
#import "NewPageViewController.h"

@interface FirstViewController ()<UITableViewDataSource>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Table ViewのデータソースにView Controller自身を設定する
    self.listTableView.dataSource = self;
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
//    UITableViewCell *tvcell = [tableView dequeueReusableCellWithIdentifier: @"cid"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [userDefault objectForKey:@"challenges"];
    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"ListView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    //セルに ar を番号順に突っ込む
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[ary objectAtIndex:indexPath.row]];
    NSLog (@"%@",cell);
    return cell;

//    if (tvcell == nil) {
//        tvcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
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

@end

