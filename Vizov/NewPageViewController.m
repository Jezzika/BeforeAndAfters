//
//  NewPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "NewPageViewController.h"
#import "PersonalPageViewController.h"
#import "CLImageEditor.h"

@interface NewPageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,CLImageEditorDelegate,UITextFieldDelegate,FUIAlertViewDelegate>
{
    UIButton *_myButton;
    UIView *_myView;
    UIDatePicker *_myDatePicker;

    //Viewの表示フラグ YES = 表示 NO = 非表示
    BOOL _isVisible;

}

@property (nonatomic) NSString *setFinalDate;
@property (nonatomic) NSDate *notificationDate;
@property (nonatomic) NSDate *finaldate;




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
    
    //デザイン用のメソッドを作成
    [self objectsDesign];
    
    // デリゲートを設定
    self.makeNewTitle.delegate = self;
    

}

-(void)viewDidAppear:(BOOL)animated{
    
    //〜時間設定〜
    
    //オレンジ色のビューオブジェクトを生成
    [self createdView];
    
    //オレンジ色のビューオブジェクトに紐付いたDatePickerを生成
    [self createdDatePicker];
    
    //btnオブジェクトの生成
    [self createdBtn];
    
    //最初は非表示なのでNO
    _isVisible = NO;
    
    //キーボードの閉じるボタンの作成
    UIView* accessoryView =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    accessoryView.backgroundColor = [UIColor whiteColor];
    
    // ボタンを作成する。
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(210,10,100,30);
    [closeButton setTitle:@"Back" forState:UIControlStateNormal];
    // ボタンを押したときによばれる動作を設定する。
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンをViewに貼る
    [accessoryView addSubview:closeButton];
    
    self.makeNewDetail.inputAccessoryView = accessoryView;

}

-(void)closeKeyboard:(id)sender{
    [self.makeNewDetail resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnNewTitle:(id)sender {
    //キーボードがreturn押して落ちるように、このメソッドの存在は消さない！
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 25;
    
    // 入力済みのテキストを取得
    NSMutableString *str = [self.makeNewTitle.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:string];
    
    if ([str length] > maxInputLength) {
        
        // ※ここに文字数制限を超えたことを通知する処理を追加
        FUIAlertView *alert = [[FUIAlertView alloc]
                              initWithTitle:@"Error"
                              message:@"Maximum characters: 25"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.titleLabel.textColor = [UIColor cloudsColor];
        alert.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        alert.messageLabel.textColor = [UIColor cloudsColor];
        alert.messageLabel.font = [UIFont flatFontOfSize:14];
        alert.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
        alert.alertContainer.backgroundColor = [UIColor midnightBlueColor];
        alert.defaultButtonColor = [UIColor cloudsColor];
        alert.defaultButtonShadowColor = [UIColor asbestosColor];
        alert.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
        alert.defaultButtonTitleColor = [UIColor asbestosColor];
        
        [alert show];
        
        return NO;
    }
    
    // チェック対象の文字を複数定義
    NSString *strNgWord = @"\"\\#$%&'()@[]{}|^~=;:?<>,/-*.";
    
    // 無効な文字列が含まれていないかどうかチェック
    for (int i=0; i<[strNgWord length]; i++) {
        
    // チェック対象の文字を設定
    NSString *strCk = [strNgWord substringWithRange:NSMakeRange(i, 1)];
        
    // 入力値がNGワードと一致する場合
        if ([string isEqual:strCk]) {
        // 入力取り消し
        return NO;
        }
    }

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // キーボードを隠す
    [self.view endEditing:YES];
    
    return YES;
}

- (BOOL)textViewShouldReturn:(UITextView *)targetTextView {
    
    // キーボードを閉じる
    [targetTextView resignFirstResponder];
    
    return YES;
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
    
    
    if ([self.makeNewTitle.text  isEqual:@""] || [self.makeNewDetail.text isEqual:@""] || [self.beforeImageView.image isEqual:@"<>"] || [self.setFinalDate isEqualToString:strNow] || self.setFinalDate == nil){
            
            FUIAlertView *alert = [[FUIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:@"Fill in the blanks"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        alert.titleLabel.textColor = [UIColor cloudsColor];
        alert.titleLabel.font = [UIFont boldFlatFontOfSize:16];
        alert.messageLabel.textColor = [UIColor cloudsColor];
        alert.messageLabel.font = [UIFont flatFontOfSize:14];
        alert.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
        alert.alertContainer.backgroundColor = [UIColor midnightBlueColor];
        alert.defaultButtonColor = [UIColor cloudsColor];
        alert.defaultButtonShadowColor = [UIColor asbestosColor];
        alert.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
        alert.defaultButtonTitleColor = [UIColor asbestosColor];
        
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
        NSString *type = @"now"; //now,success,failure のどれか（ここではnow)
        
        //カウントダウン日数のデータ
        NSString *countDown = self.finishSetLabel.text;
        
        //終了日
        NSString *finDate = self.setFinalDate;
    
        // 入力したいデータを辞書型にまとめる
        NSMutableDictionary *dic = @{@"id": [NSNumber numberWithInt:num], @"title": title, @"detail": detail, @"picture": picture, @"type": type, @"timer":countDown, @"finDate":finDate, @"startDate":strNow}.mutableCopy;
        
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

- (IBAction)finishDateBtn:(id)sender {
    [UIView beginAnimations:@"animateViewrOn" context:nil];
    [UIView setAnimationDuration:0.3];
    
    if(_isVisible == NO){
        _myButton.frame = CGRectMake(150, 200, 40, 20);
        _myView.frame = CGRectMake(0, self.view.bounds.size.height-290, self.view.bounds.size.width, 290);
        _myDatePicker.frame = CGRectMake(0, 0, 400, 20);
        _isVisible = YES;
    }
    
    [UIView commitAnimations];
}


- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // ボタンインデックスをチェックする
    if (buttonIndex >= 2) {
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


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
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
    
    CLImageEditor *editor;
    if (tmp_w < tmp_h) {
        // 画像を表示する
        self.beforeImageView.image = img_2;
        editor = [[CLImageEditor alloc] initWithImage:img_2];
    } else {
        self.beforeImageView.image = img_1;
        editor = [[CLImageEditor alloc] initWithImage:img_1];
        
    }
    
    editor.delegate = self;
    
    //モーダルで呼び出す
    [picker presentViewController:editor animated:YES completion: nil];

}

- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    self.beforeImageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];

}


- (void) imageEditorDidCancel:(CLImageEditor *)editor{
    // Editorを隠す
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    // イメージピッカーを隠す
    [self dismissViewControllerAnimated:YES completion:nil];
}

//〜ここから時間設定〜

//ボタンオブジェクト(Timer用）
-(void)createdBtn{
    
    //ボタンオブジェクトを生成
    _myButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 200, 40, 20)];
    [_myButton setTitle:@"SET" forState:UIControlStateNormal];
    
    //ボタンの文字色指定
    [_myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //メソッドとの紐付け
    [_myButton addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_myView addSubview:_myButton];
    
}


//ビューオブジェクトを生成するメソッド(Timer用）
-(void)createdView{
    
    _myView = [[UIView alloc] init];
    
    //場所を決定
    _myView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    _myView.alpha = 1.0;
    
    //ビューの色を設定
    [_myView setBackgroundColor:[UIColor turquoiseColor]];
    
    [self.view addSubview:_myView];
    
}

//ビューに紐付いたデートピッカーオブジェクト(Timer用）
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

//tapされた時に反応するメソッド(Timer)
-(void)tapBtn:(UIButton *)myButton{
    
    [UIView beginAnimations:@"animateViewrOn" context:nil];
    [UIView setAnimationDuration:0.3];
    
    //自作メソッドの使用
    [self downObjectsTimer];
    [UIView commitAnimations];
    
}


//オブジェクトを下げるメソッド
//タイマーの設定
-(void)downObjectsTimer{
    
    _myButton.frame = CGRectMake(150, 200, 40, 20);
    _myView.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    _myDatePicker.frame = CGRectMake(0, 0, 400, 20);
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
    
    self.finishSetLabel.text = [NSString stringWithFormat: @"%d days", mySince];
    
    } else {
        
    }
    
    //セットされた日付を取得
    self.setFinalDate = settedDate;
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

- (void)objectsDesign{
    
    // NowBtnDesignFalat化
    self.NowBtnDesign.buttonColor = [UIColor turquoiseColor];
    self.NowBtnDesign.shadowColor = [UIColor greenSeaColor];
    self.NowBtnDesign.shadowHeight = 3.0f;
    self.NowBtnDesign.cornerRadius = 6.0f;
    self.NowBtnDesign.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [self.NowBtnDesign setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.NowBtnDesign setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    //NavigationItemの色
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor turquoiseColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor turquoiseColor];

    
    //TextViewメモに枠線をつける
    self.makeNewDetail.layer.borderWidth = 3;
    self.makeNewDetail.layer.borderColor = [[UIColor sunflowerColor] CGColor];
    self.makeNewDetail.layer.cornerRadius = 6;
    
    //beforeLabelに枠線をつける
    self.beforeLabel.layer.borderWidth = 3;
    self.beforeLabel.backgroundColor = [UIColor turquoiseColor];
    self.beforeLabel.layer.cornerRadius = 3;
    self.beforeLabel.layer.borderColor = (__bridge CGColorRef)([UIColor sunflowerColor]);
    self.beforeLabel.clipsToBounds = true;
    
    //goalImageに枠線をつける
    self.goalLabel.layer.borderWidth = 3;
    self.goalLabel.backgroundColor = [UIColor turquoiseColor];
    self.goalLabel.layer.cornerRadius = 3;
    self.goalLabel.layer.borderColor = (__bridge CGColorRef)([UIColor sunflowerColor]);
    self.goalLabel.clipsToBounds = true;
    
    //finishImageに枠線をつける
    self.finishDateLabel.layer.borderWidth = 3;
    self.finishDateLabel.backgroundColor = [UIColor turquoiseColor];
    self.finishDateLabel.layer.cornerRadius = 3;
    self.finishDateLabel.layer.borderColor = (__bridge CGColorRef)([UIColor sunflowerColor]);
    self.finishDateLabel.clipsToBounds = true;
    
    
    //textFieldの線の色変更
    self.makeNewTitle.borderColor = [UIColor turquoiseColor];
    self.makeNewTitle.borderWidth = 2;
    self.makeNewTitle.cornerRadius = 3;
    

}



@end
