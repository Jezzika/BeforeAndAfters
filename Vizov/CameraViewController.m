//
//  CameraViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "CameraViewController.h"
#import "PersonalPageViewController.h"
#import "CLImageEditor.h"

@interface CameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIActionSheetDelegate,CLImageEditorDelegate>

@property (nonatomic) NSMutableArray *challengesNow;

@property (nonatomic) NSString *selectTitle;
@property (weak, nonatomic) IBOutlet UILabel *rara;


@end

@implementation CameraViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    

    
    }
    
    
    // textViewはUITextView型の変数
    self.textView.delegate = self;
    
    //デザインの処理メソッドを作成
    [self objectsDesign];
    
    self.rara.backgroundColor = [UIColor turquoiseColor];
    self.rara.textColor = [UIColor whiteColor];



    
}

- (void) viewDidAppear:(BOOL)animated {
    
    
    //キーボードの閉じるボタンの作成
    UIView* accessoryView =[[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)];
    accessoryView.backgroundColor = [UIColor whiteColor];
    
    // ボタンを作成する。
    FUIButton* closeButton = [FUIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(210,10,100,30);
    [closeButton setTitle:@"Back" forState:UIControlStateNormal];
    // ボタンを押したときによばれる動作を設定する。
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンをViewに貼る
    [accessoryView addSubview:closeButton];
    
    self.textView.inputAccessoryView = accessoryView;
    
    //デザインの処理メソッドを作成
    [self objectsDesign];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    //デザインの処理メソッドを作成
    [self objectsDesign];

}

-(void)closeKeyboard:(id)sender{
    [self.textView resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)selectPhotoBtn:(id)sender {
    
    // アクションシートを作る
    UIActionSheet*  sheet;
    sheet = [[UIActionSheet alloc]
             initWithTitle:@"Select Image"
             delegate:self
             cancelButtonTitle:@"Cancel"
             destructiveButtonTitle:nil
             otherButtonTitles:@"Photo Library", @"Camera", nil];
    
    // アクションシートを表示する
    [sheet showInView:self.view];
    
}

- (IBAction)cancelBtn:(id)sender {
    //キャンセルで画面を閉じる
    [self dismissViewControllerAnimated:YES completion:nil];

}

//SAVEボタン押された後の処理
- (IBAction)saveBtn:(id)sender {
    
    // 現状で保存されているデータ一覧を取得
    NSUserDefaults *usr =[NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [usr objectForKey:@"challenges"];
    NSDictionary *dic = [usr objectForKey:@"selectedDic"];
    
    //選択されたイベントのIDを取得
    NSNumber *id = [dic valueForKey:@"id"];
    
    // UIImage → NSData変換
    NSData *picture = [NSData dataWithData:UIImagePNGRepresentation(self.cameraPic.image)];
    
    //画像選択日（today)
    //初期化
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //日付のフォーマット指定
    df.dateFormat = @"yyyy/MM/dd";
    
    NSDate *today = [NSDate date];
    
    // 日付(NSDate) => 文字列(NSString)に変換
    NSString *strToday = [df stringFromDate:today];
    
    //書いたメモの処理
    NSString *memo = self.textView.text;
    
    // 入力したいデータを辞書型にまとめる
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary = @{@"id": id, @"picture": picture, @"memo": memo, @"date":strToday}.mutableCopy;
    
    
    // 現状で保存されているデータ一覧を取得した後の処理
    [usr setObject:dictionary forKey:@"selectedPic"];
    [usr synchronize];
    
    //カメラで撮影された画像 UserDefault
    NSMutableDictionary *selectedPic = [usr objectForKey:@"selectedPic"];
    NSData *selectedPicture = [selectedPic valueForKey:@"picture"];
    NSString *selectedMemo = [selectedPic valueForKey:@"memo"];
    
    
    //カメラで取った写真 or メモがある場合にそのイベントに写真を紐づけるUserDefaultを作成
    if (selectedPicture || selectedMemo) {
        
        NSString *date = [selectedPic valueForKey:@"date"];
        NSNumber *id1 = [selectedPic valueForKey:@"id"];
        NSString *memo = [selectedPic valueForKey:@"memo"];
        
        NSNumber *eventId   = [NSNumber new];
        for (NSDictionary *dic in ary) {
            if ([[dic valueForKey:@"id"] isEqualToNumber:id1]) {
                eventId = [dic valueForKey:@"id"];
            }
        }
        
        // 入力したいデータを辞書型にまとめる
        NSMutableDictionary *dic = [NSMutableDictionary new];
        
        dic = @{@"id": eventId, @"picture": selectedPicture, @"memo": memo, @"date":date}.mutableCopy;
        
        // 現状で保存されているデータ一覧を取得
        NSMutableArray *array = [[usr objectForKey:@"dailyPictures"] mutableCopy];
        if ([array count] > 0) {
            [array addObject:dic];
            [usr setObject:array forKey:@"dailyPictures"];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:dic, nil];
            [usr setObject:array forKey:@"dailyPictures"];
        }
        [usr synchronize];
        
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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
    
    CLImageEditor *editor;
    if (tmp_w < tmp_h) {
        // 画像を表示する
        self.cameraPic.image = img_2;
        editor = [[CLImageEditor alloc] initWithImage:img_2];
    } else {
        self.cameraPic.image = img_1;
        editor = [[CLImageEditor alloc] initWithImage:img_1];
        
    }
    

    
    editor.delegate = self;
    
    //モーダルで呼び出す
    [picker presentViewController:editor animated:YES completion: nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    // イメージピッカーを隠す
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)imageEditor:(CLImageEditor *)editor didFinishEdittingWithImage:(UIImage *)image
{
    self.cameraPic.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textViewShouldReturn:(UITextView *)targetTextView {
    
    // キーボードを閉じる
    [targetTextView resignFirstResponder];
    
    return YES;
}

//TextFieldに文字を入力する時にキーボードに隠れないようにする処理
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSInteger marginFromKeyboard = 10;
    NSInteger keyboardHeight = 300;
    
    CGRect tmpRect = self.textView.frame;
    if ((tmpRect.origin.y + tmpRect.size.height + marginFromKeyboard + keyboardHeight) > self.ScrollView.frame.size.height) {
        NSInteger yOffset;
        yOffset = keyboardHeight + marginFromKeyboard + tmpRect.origin.y + tmpRect.size.height - self.ScrollView.frame.size.height;
        [self.ScrollView setContentOffset:CGPointMake(0, yOffset) animated:YES];
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    [self.ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


- (void)objectsDesign{
    
    //スクロールビューの背景を変更
    self.ScrollView.backgroundColor = [UIColor whiteColor];
    
    
    if ([self.cameraPic.image  isEqual: [UIImage imageNamed:@"noimage2"]] || !(self.textView.text)) {
        //ボタンの文字色指定（最初うっすら透明）
        self.saveBtnItem.tintColor = [UIColor whiteColor];
        self.saveBtnItem.enabled = NO;
    } else {
        self.saveBtnItem.tintColor = [UIColor turquoiseColor];
        self.saveBtnItem.enabled = YES;
    }
    
    //TextViewに枠線をつける
    self.textView.layer.borderWidth = 3;
    self.textView.layer.borderColor = [[UIColor turquoiseColor] CGColor];
    self.textView.layer.cornerRadius = 6;
    
    
    //BarBtnItemsに色づけ
    self.cancelBtnItem.tintColor = [UIColor turquoiseColor];
    
 
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
