//
//  PersonalPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/22/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "PersonalPageViewController.h"
#import "PersonalTableViewCell.h"

@interface PersonalPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSDictionary * tableDict;

@end

@implementation PersonalPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view

    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];

    
    //UserDefaultの個別データ表示(ホームの一覧リストから）
    NSString *title;
    NSString *detail;
    NSData *pictData;
    UIImage *picture;
    
    
    
    if (self.fromFirstView) {
        title = [[usrDefault objectForKey:@"selectedAry"]valueForKeyPath:@"title"];
        
        detail = [[usrDefault objectForKey:@"selectedAry" ]valueForKeyPath:@"detail"];
        
        pictData = [[usrDefault objectForKey:@"selectedAry" ]valueForKeyPath:@"picture"];
        
        // NSData→UIImage変換
        picture = [UIImage imageWithData:pictData];
        
        NSString *finDate = [[usrDefault objectForKey:@"selectedAry"] valueForKey:@"finDate"];
        
        //初期化(カウントダウン用のデータ作成）
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        
        //日付のフォーマット指定
        df.dateFormat = @"yyyy/MM/dd";
        
        NSDate *today = [NSDate date];
        
        // 日付(NSDate) => 文字列(NSString)に変換
        NSString *strNow = [df stringFromDate:today];
        NSDate *currentDate= [df dateFromString:strNow];
        
        NSDate *setFinDate = [df dateFromString:finDate];
        
        // dateBとdateAの時間の間隔を取得(dateA - dateBなイメージ)
        NSTimeInterval  since = [setFinDate timeIntervalSinceDate:currentDate];
        int mySince = (int) since/(24*60*60);
        if (mySince > 0){
            self.settedTimer.text = [NSString stringWithFormat:@"%d",mySince];
        } else {
        }

        
        self.settedTitle.text = title;
        self.settedBeforePicture.image = picture;
        self.settedDetail.text = detail;
        
    }

    
    if (self.fromCameraView){
        NSLog(@"%@",@"カメラから帰ってきたよ〜");
    }

    self.listDetailTable.delegate = self;
    self.listDetailTable.dataSource = self;
    self.listDetailTable.allowsSelection = YES;
    

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Table Viewの行数を返す
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [userDefault objectForKey:@"selectedAry"];
    NSString *timer = [ary valueForKey:@"timer"];
    int num = [timer intValue];
    int i = 1;
    while (i < num) {
        i++;
    }
    
    return i;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    //セルの名前をつける。StorybordのprototypeのセルのIdentifierで設定しないとエラーになる。
    static NSString *CellIdentifier = @"DailyList";
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    if (cell == nil) {
        cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefault objectForKey:@"selectedAry"];
    NSString *timer = [dict valueForKey:@"timer"];
    int num = [timer intValue];
    
    NSMutableArray *tableAry = [NSMutableArray array];
    int i;
    for (i=1; i<num; i++) {
        [tableAry addObject:[NSString stringWithFormat:@"%d",i]];
    }
    


    //カスタムセルにデータを渡して表示処理を委譲
//    self.tableDict = tableAry;
    [cell setData:tableAry];

    return cell;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
