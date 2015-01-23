//
//  NewPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "NewPageViewController.h"


@interface NewPageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource>
{
    UIButton *_myButton;
    UIView *_myView;
    UIDatePicker *_myDatePicker;
    
    //Viewの表示フラグ YES = 表示 NO = 非表示
    BOOL _isVisible;
    
}



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
    
    //btnオブジェクトの生成
    [self createdBtn];
    
    
    //オレンジ色のビューオブジェクトを生成
    [self createdView];
    
    //最初は非表示なのでNO
    _isVisible = NO;
    
    //オレンジ色のビューオブジェクトに紐付いたテキストフィールドを生成
    [self createdDatePicker];
    

    
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
             otherButtonTitles:@"Photo Library", @"Camera", @"Saved Photos", nil];
    
    // アクションシートを表示する
    [sheet showInView:self.view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"NowSegue"]) {
        // 入力したいデータを取り出し
        NSString *title = self.makeNewTitle.text;
        NSString *detail = self.makeNewDetail.text;
        
        // 入力したいデータを辞書型にまとめる
        NSDictionary *dic = @{@"title": title, @"detail": detail};

        // 現状で保存されているデータ一覧を取得
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSMutableArray *array = [userDefault objectForKey:@"challenges"];
        if ([array count] > 0) {
            [array addObject:dic];
            [userDefault setObject:array forKey:@"challenges"];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:dic, nil];
            [userDefault setObject:array forKey:@"challenges"];
        }
        [userDefault synchronize];

        
        // UserDefaultに保存（コンソールで確認するため）
        NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
        NSMutableArray *ary = [usrDefault objectForKey:@"challenges"];
        NSLog(@"%@", ary);

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
        case 2: {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        }
    }
    
    // 使用可能かどうかチェックする
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        return;
    }
    
    // イメージピッカーを作る
    UIImagePickerController*    imagePicker;
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = sourceType;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    // イメージピッカーを表示する
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController*)picker
        didFinishPickingImage:(UIImage*)image
                  editingInfo:(NSDictionary*)editingInfo
{
    //ImagePickerのデリケードメソッド (画像取得時)
        // グラフィックスコンテキストを作る
        CGSize  size = { 240, 240 };
        UIGraphicsBeginImageContext(size);
        
        // 画像を縮小して描画する
        CGRect  rect;
        rect.origin = CGPointZero;
        rect.size = size;
        [image drawInRect:rect];
        
        // 描画した画像を取得する
        UIImage*    shrinkedImage;
        shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 画像を表示する
        _beforeImageView.image = shrinkedImage;
        
        // イメージピッカーを隠す
        [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    // イメージピッカーを隠す
    [self dismissModalViewControllerAnimated:YES];
}


//〜ここから、設定画面に〜

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
    
    return cell;
    

}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[NSString stringWithFormat:@"%d", indexPath.row] forKey:@"num"];
    
    //[self performSegueWithIdentifier:@"rowNumber" sender:self];
    if (indexPath.row == 0){
        
        [UIView beginAnimations:@"animateViewrOn" context:nil];
        [UIView setAnimationDuration:0.3];
        
        if(!_isVisible){
            _myButton.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            _myView.frame = CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290);
            _myDatePicker.frame = CGRectMake(0, 0, 400, 20);
            _isVisible = YES;
        }else{
            
            //自作メソッドの使用
            [self downObjects];
            
        }
        
        [UIView commitAnimations];
        
    } else if(indexPath.row == 1) {
        nil;
    }
}


//~ここから時間設定~

//ボタンオブジェクトを生成するメソッド
-(void)createdBtn{
    
    //ボタンオブジェクトを生成
    
    _myButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 0, 40, 20)];
    
    [_myButton setTitle:@"設定終了" forState:UIControlStateNormal];
    
    //ボタンの文字色指定
    [_myButton setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1] forState:UIControlStateNormal];
    
    [_myButton setBackgroundColor:[UIColor redColor]];
    
    //メソッドとの紐付け
    [_myButton addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_myView addSubview:_myButton];
    
    // 重なり順を最前面に
    [_myView bringSubviewToFront:_myButton];
}

//オレンジ色のビューオブジェクトを生成するメソッド
-(void)createdView{
    
    _myView = [[UIView alloc] init];
    
    //場所を決定
    _myView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    _myView.alpha = 1.0;
    
    //ビューの色を設定
    [_myView setBackgroundColor:[UIColor colorWithRed:1.0 green:0.54901 blue:0 alpha:1]];
    
    [self.view addSubview:_myView];
    
    // 重なり順を最前面に
    //[self.view bringSubviewToFront:_myView];
    
}

//オレンジ色のビューに紐付いたデートピッカーオブジェクトを作成するめそっど
-(void)createdDatePicker{
    
    //デートピッカーオブジェクトを生成
    _myDatePicker = [[UIDatePicker alloc] init];
    
    //場所を決定
    _myDatePicker.frame = CGRectMake(0, 0, self.view.bounds.size.width, 10);
    _myDatePicker.alpha = 1.0;
    
    // デートピッカーの色を設定
    [_myDatePicker setBackgroundColor:[UIColor blueColor]];
    
    
    //_myViewに追加してあげる
    [_myView addSubview:_myDatePicker];
    
    
}

//tapされた時に反応するメソッド
-(void)tapBtn:(UIButton *)myButton{
    
    
    [UIView beginAnimations:@"animateViewrOn" context:nil];
    [UIView setAnimationDuration:0.3];
    
    if(!_isVisible){
        _myButton.frame = CGRectMake(280, self.view.bounds.size.height-310, 40, 20);
        _myView.frame = CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290);
        _myDatePicker.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
        _isVisible = YES;
    }else{
        
        //自作メソッドの使用
        [self downObjects];
        
    }
    
    [UIView commitAnimations];
    
}


//Returnキーが押された時に反応するメソッド
-(void)tapReturn{
    
    NSLog(@"Return");
    
    self->_myDatePicker.datePickerMode = UIDatePickerModeTime;
    
        //TODO:ボタンやビューが下がる処理を記述
        [UIView beginAnimations:@"animateViewrOn" context:nil];
        [UIView setAnimationDuration:0.3];
        
        //自作メソッドの使用
        [self downObjects];
        
        [UIView commitAnimations];
}

//オブジェクトを下げるメソッド
-(void)downObjects{
    
    _myButton.frame = CGRectMake(50, 50, 40, 20);
    _myView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    _myDatePicker.frame = CGRectMake(0, 0, 50, 50);
    _isVisible = NO;
}




@end
