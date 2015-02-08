//
//  ListTableViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/26/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "ListTableViewController.h"
#import "ListTableViewCell.h"

@interface ListTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic) NSMutableArray *now;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [usrDefault objectForKey:@"selectedSuccessAry"];
    
    NSIndexPath *indexPath = self.listTableView.indexPathForSelectedRow;
    NSArray *selectedArray = ary[indexPath.row];
    
    
    //UserDefaultの個別データ表示(ホームの一覧リストから）
    NSArray *title;
    NSArray *detail;
    NSData *pictData;
    UIImage *picture;
//    NSString *timer;
    
    
    
    if (self.fromFirstView) {
        title = [selectedArray valueForKeyPath:@"title"];
        
        detail = [selectedArray valueForKeyPath:@"detail"];
        
        pictData = [selectedArray valueForKeyPath:@"picture"];
        
        // NSData→UIImage変換
        picture = [UIImage imageWithData:pictData];
        
//        timer = [[usrDefault objectForKey:@"selectedSuccessAry"] valueForKey:@"timer"];
        
    }
    
    self.doneListTableView.delegate = self;
    self.doneListTableView.dataSource = self;
    self.doneListTableView.allowsSelection = YES;
    


    
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
    NSUserDefaults *usr = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [usr objectForKey:@"challenges"];
    
    NSMutableArray *challengesDone = [NSMutableArray new];
    for (NSDictionary *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"success"]||[[dic valueForKey:@"type"] isEqualToString:@"failure"]) {
            [challengesDone addObject:dic];
        }
    }
    
    return [challengesDone count];
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
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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

@end
