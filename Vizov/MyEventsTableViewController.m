//
//  MyEventsTableViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/27/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "MyEventsTableViewController.h"
#import "MyEventsTableViewCell.h"

@interface MyEventsTableViewController ()
@end

@implementation MyEventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        // Uncomment the following line to preserve selection between presentations.
        // self.clearsSelectionOnViewWillAppear = NO;

    
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
        NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
        NSDictionary *dic        = [usrDefault objectForKey:@"selectedDic2"];

        //UserDefaultの個別データ表示(ホームの一覧リストから）
        NSString *title;
        NSString *detail;
        NSData *pictData;
        UIImage *picture;
        NSString *finDate;

        if (self.fromListView) {
            title = [dic valueForKeyPath:@"title"];
            
            detail = [dic valueForKeyPath:@"detail"];
            
            pictData = [dic valueForKeyPath:@"picture"];
            
            // NSData→UIImage変換
            picture = [UIImage imageWithData:pictData];
            
            finDate = [dic valueForKey:@"finDate"];
            
        }

        // Table ViewのデータソースにView Controller自身を設定する
        self.myEventsTable.delegate = self;
        self.myEventsTable.dataSource = self;
        self.myEventsTable.allowsSelection = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    // Table Viewの行数を返す
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefault objectForKey:@"selectedDic2"];
    NSString *str = [dic valueForKey:@"timer"];
    
    int myCount = (int)[str intValue];

    return myCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"MyCell";
    MyEventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyEventsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefault objectForKey:@"selectedDic2"];
    NSString *timer = [dict valueForKey:@"timer"];
    
    int num = [timer intValue];
    
    // 日付のオフセットを生成(次の日をとってくる)
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    
    // x日後のNSDateインスタンスを取得する
    //初期化
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //日付のフォーマット指定
    df.dateFormat = @"yyyy/MM/dd";
    
    NSString *date1 = [dict valueForKey:@"startDate"];
    
    //NSStringから Date型に変更
    NSDate *dateDate = [df dateFromString:date1];
    NSDate *resultDate = [NSDate new];
    
    NSString *result = [NSString string];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSMutableArray *eventDaysAry = [NSMutableArray array];
    // x日後とする
    int x;
    for (x=0; x<num; x++) {
        [dateComp setDay:x];
        resultDate = [calendar dateByAddingComponents:dateComp toDate:dateDate options:0];
        result = [df stringFromDate:resultDate];
        [eventDaysAry addObject:result];
        
    }
    
    //イベントの日付ArrayをUserDefaultにて作成
    NSMutableDictionary *daysDict = [NSMutableDictionary dictionary];
    NSNumber *id = [dict valueForKey:@"id"];//選択されたdictのid
    
    NSMutableArray *aryForDays = [NSMutableArray array];
    for (NSMutableDictionary *dict2 in eventDaysAry) {
        daysDict = @{ @"id": id,@"days":dict2}.mutableCopy;
        [aryForDays addObject:daysDict];
    }
    
    
    //aryForDaysの中に選択されたidがあるかチェックするための配列
    NSMutableArray *testAry   = [NSMutableArray array];
    for (NSMutableDictionary *dic in aryForDays) {
        if ([[[aryForDays valueForKey:@"id"]lastObject] isEqualToNumber:[dict valueForKey:@"id"]]) {
            [testAry addObject:dic];
        }
    }
    
    
    //重複データはとらない！id１個に紐づく日付の配列を作る
    NSMutableArray *testAry2 = [[userDefault objectForKey:@"daysArray"] mutableCopy];
    if ([testAry2 count] > 0){
        for (NSMutableDictionary *dic2 in aryForDays) {
            [testAry2 removeObject:dic2];
            [testAry2 addObject:dic2];
            [userDefault setObject:testAry2 forKey:@"daysArray"];
            [userDefault synchronize];
        }
    } else {
        for (NSMutableDictionary *dic2 in aryForDays) {
            NSMutableArray *testAry2 = [[NSMutableArray alloc] initWithObjects:dic2, nil];
            [testAry2 addObject:dic2];
            [userDefault setObject:testAry2 forKey:@"daysArray"];
            [userDefault synchronize];
        }
        
        
    }
    
    NSMutableArray *setDataAry = [[NSMutableArray array]mutableCopy];
    
    for (NSMutableDictionary *dic in testAry2) {
        if ([dict valueForKey:@"id"] == [dic valueForKey:@"id"]){
            [setDataAry addObject:dic];
        }
    }
    
    
    NSMutableDictionary *eventDaysArySet =[[NSMutableDictionary dictionary]mutableCopy];
    
    eventDaysArySet = setDataAry[indexPath.row];
    
    
    //カスタムセルにデータを渡して表示処理を委譲
    [cell setData:eventDaysArySet];
    
    return cell;
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)shareButton:(id)sender {
    
    NSString *text = @"Vizov/Before and Afters";
    NSURL *url = [NSURL URLWithString:@"http://google.com"];
    NSArray *activityItems = @[text];
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    //セグエ線を使用しない場合のモーダル表示
    [self presentViewController:activityView animated:YES completion:nil];

}
@end
