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
        NSDictionary *dic        = [usrDefault objectForKey:@"selectedAry2"];

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
    NSDictionary *dic = [userDefault objectForKey:@"selectedAry2"];
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
    NSDictionary *dict = [userDefault objectForKey:@"selectedAry2"];
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
    
    NSLog(@"ぬあああ%@",eventDaysArySet);
    
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
