//
//  NewPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "NewPageViewController.h"
#import "PersonalPageViewController.h"


@interface NewPageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource,UIActionSheetDelegate>
{
    UIButton *_myButton;
    UIButton *_myButton2;
    UIView *_myView;
    UIView *_myView2;
    UIDatePicker *_myDatePicker;
    UIDatePicker *_myDatePicker2;
    
    //Viewの表示フラグ YES = 表示 NO = 非表示
    BOOL _isVisible;
    

}

@property (nonatomic) NSString *setFinalDate;
@property (nonatomic) NSDate *notificationDate;
@property (nonatomic) NSDate *finaldate;
@property (nonatomic) UILabel *tag1;
@property (nonatomic) UILabel *tag2;




@end


@implementation NewPageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //データを読み込む
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [myDefaults stringForKey:@"myString"];
    
    
    //もし読み出したデータが空でなかったらテキストフィールドに設定
    if (str != NULL) {
        self.makeNewTitle.text = str;
    }
    
    self.setTableView.delegate = self;
    self.setTableView.dataSource = self;
    self.CellNames = [NSArray arrayWithObjects:@"CellFirst", @"CellSecond", @"CellThird", nil];
    
    
    
    

}

-(void)viewDidAppear:(BOOL)animated{
    
    //〜時間設定〜
    
    //オレンジ色のビューオブジェクトを生成
    [self createdView];
    [self createdView2];
    
    //オレンジ色のビューオブジェクトに紐付いたDatePickerを生成
    [self createdDatePicker];
    [self createdDatePicker2];
    
    //btnオブジェクトの生成
    [self createdBtn];
    [self createdBtn2];
    
    //最初は非表示なのでNO
    _isVisible = NO;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)returnNewTitle:(id)sender {
    //キーボードがreturn押して落ちるように、このメソッドの存在は消さない！
}

- (IBAction)returnNewDetail:(id)sender {
    //キーボードがreturn押して落ちるように、このメソッドの存在は消さない！
}

- (IBAction)showCameraSheet:(id)sender {
    // アクションシートを作る
    UIActionSheet*  sheet;
    sheet = [[UIActionSheet alloc]
             initWithTitle:@"Before Image"
             delegate:self
             cancelButtonTitle:@"Cancel"
             destructiveButtonTitle:nil
             otherButtonTitles:@"Photo Library", @"Camera", /*@"Saved Photos",*/ nil];
    
    
    // アクションシートを表示する
    [sheet showInView:self.view];
}

- (IBAction)tapNowButton:(id)sender {

        //初期化
        NSDateFormatter *df = [[NSDateFormatter alloc] init];

        //日付のフォーマット指定
        df.dateFormat = @"yyyy/MM/dd";

        NSDate *today = [NSDate date];
    
        // 日付(NSDate) => 文字列(NSString)に変換
        NSString *strNow = [df stringFromDate:today];
    
    
    
    if ([self.makeNewTitle.text  isEqual:@""] || [self.makeNewDetail.text isEqual:@""] || [self.beforeImageView.image isEqual:@"<>"] || [self.setFinalDate isEqualToString:strNow]){
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"エラー"
                                  message:@"空欄を入力して下さい"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            
            
        } else {
            
    

        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        // 入力したいデータを取り出し
        NSString *title = self.makeNewTitle.text;
        NSString *detail = self.makeNewDetail.text;
        UIImage *img =  self.beforeImageView.image;
        
        //入力したいデータ　（データ番号）
        int num = (int)[userDefault integerForKey:@"maxId"];
        if (num == nil){
            num = 1;
            [userDefault setInteger:num forKey:@"maxId"];
        } else {
            num ++;
            [userDefault setInteger:num forKey:@"maxId"];
        }
            
        // UIImage → NSData変換
        NSData *picture = [NSData dataWithData:UIImagePNGRepresentation(img)];
        
        //タイプのデータ
        NSString *type = @"now"; //0=now,1=yet,2=success,3=failure のどれか（ここではnow)
        
        //カウントダウン日数のデータ
        NSString *countDown = self.tag1.text;
        
        //終了日
        NSString *finDate = self.setFinalDate;
    
        
        //通知タイム
        NSString *notification = self.tag2.text;
        
        // 入力したいデータを辞書型にまとめる
        NSDictionary *dic = @{@"id": [NSNumber numberWithInt:num], @"title": title, @"detail": detail, @"picture": picture, @"type": type, @"timer":countDown, @"finDate":finDate, @"startDate":strNow, @"notification": notification};
        
        // 現状で保存されているデータ一覧を取得
        
        NSMutableArray *array = [[userDefault objectForKey:@"challenges"] mutableCopy];
        if ([array count] > 0) {
            [array addObject:dic];
            [userDefault setObject:array forKey:@"challenges"];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:dic, nil];
            [userDefault setObject:array forKey:@"challenges"];
        }
        [userDefault synchronize];
    
    
        //通知アラート設定-------------------------------------
        //現在日付
        NSDate *now = [NSDate date];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *comp = [[NSDateComponents alloc] init];
        [comp setDay:0];
        
        // 現在から指定した日付との差分を、日を基準にして取得する。
        NSDateComponents *def1 = [cal components:NSCalendarUnitDay fromDate:now toDate:self.finaldate options:0];
        
        int countdownDayNumber = (int)[def1 day];
        
        
        //インスタンス化(ローカル通知を作成）
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        if (localNotification == nil){
            return;
        }
        
        // NSDateFormatter を用意します。
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        // 変換用の書式を設定
        [formatter setDateFormat:@"HH:mm"];
        
        
        //-------- localNotificationの設定 -------------------
        countdownDayNumber = countdownDayNumber + 1;
        
        //通知を受ける時刻を指定
        localNotification.fireDate = self.notificationDate;
        
        //通知メッセージの本文(チャレンジのタイトル)
        localNotification.alertBody = [NSString stringWithFormat:@"%@:あと%d日です",title,countdownDayNumber];
        
        //アイコンバッチの数字
        localNotification.applicationIconBadgeNumber = countdownDayNumber;
        
        //通知メッセージアラートのボタンに表示される文字を指定
        localNotification.alertAction = @"Open";
        
        // 効果音は標準の効果音を利用する(バイブも）
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        // タイムゾーンを指定する
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        // 毎日繰り返す
        localNotification.repeatInterval = NSCalendarUnitDay;
        
        //作成した通知イベント情報をアプリケーションに登録
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        
        
        //-------- localNotification End ----------------------
    
        
        // UserDefaultに保存（コンソールで確認するため）
        NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ary = [usrDefault objectForKey:@"challenges"];
        NSLog(@"%@", ary);
    
        //一つ前の画面に戻す
        [self.navigationController popViewControllerAnimated:YES];
        
        }


}

- (IBAction)tapLaterButton:(id)sender {
    
        //初期化
        NSDateFormatter *df = [[NSDateFormatter alloc] init];

        //日付のフォーマット指定
        df.dateFormat = @"yyyy/MM/dd";

        NSDate *today = [NSDate date];

        // 日付(NSDate) => 文字列(NSString)に変換
        NSString *strNow = [df stringFromDate:today];


    
    if ([self.makeNewTitle.text  isEqual:@""] || [self.makeNewDetail.text isEqual:@""] || [self.beforeImageView.image isEqual:@""] || [self.setFinalDate isEqualToString:strNow]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"エラー"
                                  message:@"空欄を入力して下さい"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            
        
    } else {
    
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        // 入力したいデータを取り出し
        NSString *title = self.makeNewTitle.text;
        NSString *detail = self.makeNewDetail.text;
        UIImage *img =  self.beforeImageView.image;
        
        //入力したいデータ　（データ番号）
        int num = (int)[userDefault integerForKey:@"maxId"];
        if (num == nil){
            num = 1;
            [userDefault setInteger:num forKey:@"maxId"];
        } else {
            num ++;
            [userDefault setInteger:num forKey:@"maxId"];
        }
        
        // UIImage → NSData変換
        NSData *picture = [NSData dataWithData:UIImagePNGRepresentation(img)];
        
        //タイプのデータ
        NSString *type = @"yet"; //0=now,1=yet,2=success,3=failure のどれか（ここではnow)
        
        //カウントダウン日数のデータ
        NSString *countDown = self.tag1.text;
        
        //終了日
        NSString *finDate = self.setFinalDate;
        
        //通知タイム
        NSString *notification = self.tag2.text;
        
        // 入力したいデータを辞書型にまとめる
        NSDictionary *dic = @{@"id": [NSNumber numberWithInt:num], @"title": title, @"detail": detail, @"picture": picture, @"type": type, @"timer":countDown, @"finDate": finDate, @"notification": notification};
        
        // 現状で保存されているデータ一覧を取得
        NSMutableArray *array = [[userDefault objectForKey:@"challenges"] mutableCopy];
        if ([array count] > 0) {
            [array addObject:dic];
            [userDefault setObject:array forKey:@"challenges"];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:dic, nil];
            [userDefault setObject:array forKey:@"challenges"];
        }
        [userDefault synchronize];
    
        //一つ前の画面に戻す
        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // ボタンインデックスをチェックする
    if (buttonIndex >= 3) {
        return;
    }
    
    // ソースタイプを決定する
    UIImagePickerControllerSourceType   sourceType = 0;
    switch (buttonIndex) {
        case 0: {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        case 1: {
            sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
    }
    
    // 使用可能かどうかチェックする
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    
    // イメージピッカーを作る
    UIImagePickerController *imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    // イメージピッカーを表示する
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController*)picker
        didFinishPickingImage:(UIImage*)image
                  editingInfo:(NSDictionary*)editingInfo
{
    //ImagePickerのデリケードメソッド (画像取得時)
    
        CGFloat width = 150;    // リサイズ後幅のサイズ
        CGFloat height = 150;   // リサイズ後高さのサイズ
        CGRect rect = CGRectMake(0, 0, width, height);
        
        // 読み込んだ画像のサイズ取得
        CGFloat tmp_w = image.size.width;
        CGFloat tmp_h = image.size.height;
        
        // 選択した画像が正方形じゃなかった場合、隙間が生まれないようにリサイズする
        // 縦長の画像
        if (tmp_w < tmp_h) {
            float per   = width / tmp_w;
            width       = tmp_w * per;
            height      = tmp_h * per;
            
            rect = CGRectMake(0, -height/2 +rect.size.width/2, rect.size.width, rect.size.height);
        }
        // 横長の画像
        else if (tmp_w > tmp_h) {
            float per   = height / tmp_h;
            width       = tmp_w * per;
            height      = tmp_h * per;
            
            rect = CGRectMake(-width/2 +rect.size.height/2, 0, rect.size.width, rect.size.height);
        }
        
        // 画像の比率を保ちながらリサイズ
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [image drawInRect:CGRectMake(0, 0, width, height)];
        UIImage *img_1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 150x150サイズでトリミング
        UIGraphicsBeginImageContext(rect.size);
        [img_1 drawAtPoint:rect.origin];
        UIImage *img_2 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        // 読み込んだ画像ファイルをバイナリデータで保存
        NSData *imgData = [NSData dataWithData:UIImagePNGRepresentation(img_2)];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:imgData forKey:@"picture"];
        [defaults synchronize];
    
    
        // 画像を表示する
        self.beforeImageView.image = img_2;
        NSLog (@"%@",imgData);
    
        [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
        // イメージピッカーを隠す
        [self dismissViewControllerAnimated:YES completion:nil];
}


//〜ここから、TableView部分の設定画面に〜

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        // セクション数を返す
        return 3;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        if ([indexPath isEqual:[NSIndexPath indexPathForRow:2 inSection:0]]) {
            return nil;
        } else {
            return indexPath;
        }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *cellName = [self.CellNames objectAtIndex:indexPath.row];
        UITableViewCell *cell = [self.setTableView dequeueReusableCellWithIdentifier:cellName];
    
        //表示タグ
        self.tag1 = (UILabel *)[self.setTableView viewWithTag:1];
        self.tag2 = (UILabel *)[self.setTableView viewWithTag:2];

    
        return cell;

}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (indexPath.row == 0){
            
            [UIView beginAnimations:@"animateViewrOn" context:nil];
            [UIView setAnimationDuration:0.3];
            
            if(_isVisible == NO){
                _myButton.frame = CGRectMake(0, 0, 40, 20);
                _myView.frame = CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290);
                _myDatePicker.frame = CGRectMake(0, 0, 400, 20);
                _isVisible = YES;
            }else{
                
                //自作メソッドの使用
                [self downObjectsTimer];
                
            }
            
            [UIView commitAnimations];
            
        }
    
        if (indexPath.row == 1) {
            [UIView beginAnimations:@"animateViewrOn" context:nil];
            [UIView setAnimationDuration:0.3];
            
            if(_isVisible == NO){
                _myButton2.frame = CGRectMake(0, 0, 40, 20);
                _myView2.frame = CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290);
                 _myDatePicker2.frame = CGRectMake(0, 0, 400, 20);
                _isVisible = YES;
            }else{
                
                //自作メソッドの使用
                [self downObjectsNotification];
                
            }
            [UIView commitAnimations];

        }
}


//〜ここから時間設定〜

//ボタンオブジェクト(Timer用）
-(void)createdBtn{
    
    //ボタンオブジェクトを生成
    
    _myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    
    [_myButton setTitle:@"SET" forState:UIControlStateNormal];
    
    //ボタンの文字色指定
    [_myButton setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1] forState:UIControlStateNormal];

    
    //メソッドとの紐付け
    [_myButton addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_myView addSubview:_myButton];
    
}
//ボタンオブジェクト(Notification用）
-(void)createdBtn2{
    
    //ボタンオブジェクトを生成
    
    _myButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    
    [_myButton2 setTitle:@"設定" forState:UIControlStateNormal];
    
    //ボタンの文字色指定
    [_myButton2 setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1] forState:UIControlStateNormal];
    
    
    //メソッドとの紐付け
    [_myButton2 addTarget:self action:@selector(tapBtn2:) forControlEvents:UIControlEventTouchUpInside];
    
    [_myView2 addSubview:_myButton2];
    
}


//オレンジ色のビューオブジェクトを生成するメソッド(Timer用）
-(void)createdView{
    
    _myView = [[UIView alloc] init];
    
    //場所を決定
    _myView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    _myView.alpha = 1.0;
    
    //ビューの色を設定
    [_myView setBackgroundColor:[UIColor colorWithRed:1.0 green:0.54901 blue:0 alpha:1]];
    
    [self.view addSubview:_myView];
    
}

//オレンジ色のビューオブジェクトを生成するメソッド(Notification用）
-(void)createdView2{
    
    _myView2 = [[UIView alloc] init];
    
    //場所を決定
    _myView2.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    _myView2.alpha = 1.0;
    
    //ビューの色を設定
    [_myView2 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.54901 blue:0 alpha:1]];
    
    [self.view addSubview:_myView2];
    
}


//オレンジ色のビューに紐付いたデートピッカーオブジェクト(Timer用）
-(void)createdDatePicker{

    //_myDatePickerオブジェクトを作成
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    _myDatePicker = picker;
    
    _myDatePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _myDatePicker.datePickerMode = UIDatePickerModeDate;
    
    //datepickerの値で今日より前の日を選択できないようにする。
    _myDatePicker.minimumDate = [NSDate date];
    
    
    //_myDatePickerのサイズを選択
    CGSize size = [_myDatePicker sizeThatFits:CGSizeZero];
    _myDatePicker.frame = CGRectMake(0.0f, 150.0f, size.width, size.height);

    
    //_myViewに追加してあげる
    [_myView addSubview:_myDatePicker];
    
    
}

//オレンジ色のビューに紐付いたデートピッカーオブジェクト(Notification)
-(void)createdDatePicker2{
    
    
    //場所を決定
    _myDatePicker2.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    _myDatePicker2.alpha = 1.0;

    
    //１０分間隔に設定
    _myDatePicker2.minuteInterval = 10;
    
    //_myDatePickerオブジェクトを作成
    UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    _myDatePicker2 = picker;
    
    _myDatePicker2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _myDatePicker2.datePickerMode = UIDatePickerModeTime;
    
    
    //_myDatePickerのサイズを選択
    CGSize size = [_myDatePicker2 sizeThatFits:CGSizeZero];
    _myDatePicker2.frame = CGRectMake(0.0f, 150.0f, size.width, size.height);
    
    //_myViewに追加してあげる
    [_myView2 addSubview:_myDatePicker2];

    
}



- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
}


//tapされた時に反応するメソッド(Timer)
-(void)tapBtn:(UIButton *)myButton{
    
    
    [UIView beginAnimations:@"animateViewrOn" context:nil];
    [UIView setAnimationDuration:0.3];
    
    if(!_isVisible){
        _myButton.frame = CGRectMake(0, 0, 40, 20);
        _myView.frame = CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290);
        _myDatePicker.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        _isVisible = YES;
    }else{
        
        //自作メソッドの使用
        [self downObjectsTimer];
        
    }
    
    [UIView commitAnimations];
    
}

//tapされた時に反応するメソッド(Notification)
-(void)tapBtn2:(UIButton *)myButton{
    
    
    [UIView beginAnimations:@"animateViewrOn" context:nil];
    [UIView setAnimationDuration:0.3];
    
    if(!_isVisible){
        _myButton2.frame = CGRectMake(0, 0, 40, 20);
        _myView2.frame = CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290);
        _myDatePicker2.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        _isVisible = YES;
    }else{
        
        //自作メソッドの使用
        [self downObjectsNotification];
        
    }
    
    [UIView commitAnimations];
    
}

//オブジェクトを下げるメソッド
//タイマーの設定
-(void)downObjectsTimer{
    
    _myButton.frame = CGRectMake(50, 50, 40, 20);
    _myView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    _myDatePicker.frame = CGRectMake(0, 0, 50, 50);
    _isVisible = NO;
    
    //初期化
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    //日付のフォーマット指定
    df.dateFormat = @"yyyy/MM/dd";
    
    NSDate *today = [NSDate date];

    
    // 日付(NSDate) => 文字列(NSString)に変換
    NSString *strNow = [df stringFromDate:today];
    
    //ラベルに日付を表示
    NSString *settedDate = [df stringFromDate:_myDatePicker.date];
 
    
    NSDate *setDate = [df dateFromString:settedDate];
    
    
    self.finaldate = setDate;

    NSDate *currentDate= [df dateFromString:strNow];
    
    // dateBとdateAの時間の間隔を取得(dateA - dateBなイメージ)
    NSTimeInterval  since = [setDate timeIntervalSinceDate:currentDate];
    int mySince = (int) since/(24*60*60);
    if (mySince > 0){
    
    self.tag1.text = [NSString stringWithFormat: @"%d", mySince];
    } else {
    }
    
    //セットされた日付を取得
    self.setFinalDate = settedDate;
    
    
}

//オブジェクトを下げるメソッド
// 通知設定
-(void)downObjectsNotification{
    
    _myButton2.frame = CGRectMake(50, 50, 40, 20);
    _myView2.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    _myDatePicker2.frame = CGRectMake(0, 0, 50, 50);
    _isVisible = NO;
    
    //モードを指定
    _myDatePicker2.datePickerMode = UIDatePickerModeTime;
    
    //初期化
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    
    NSString *time = [df stringFromDate:_myDatePicker2.date];
    
    //NSStringから Data型に変更
    NSDate *date = [df dateFromString:time];
    
    self.notificationDate = date;
    
    self.tag2.text = time;
    
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}




@end
