//
//  CameraViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PersonalPageViewController.h"

@interface CameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UIButton *myButton;
@property (nonatomic) BOOL isVisible;

@property (nonatomic) UITableView *myTable;
@property (nonatomic) NSMutableArray *challengesNow;


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


    
}

- (void) viewDidAppear:(BOOL)animated {
    
    //btnオブジェクトの生成
    [self createdBtn];
    
    //動的なテーブルの作成2
    [self createTableView];
    self.isVisible = NO;
    
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    
    
}

//テーブルビューオブジェクトの作成（SAVE後）
-(void)createTableView{
    self.myTable = [[UITableView alloc] init];
    
    //場所を決定
    self.myTable.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    self.myTable.alpha = 1.0;
    
    //ビューの色を設定
    [self.myTable setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1]];
    
    [self.view addSubview:self.myTable];
    
}


//ボタンオブジェクト(SAVE)
-(void)createdBtn{
    
    //ボタンオブジェクトを生成
    self.myButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 220, self.view.bounds.size.height, self.view.bounds.size.width)];
    
    [self.myButton setTitle:@"SAVE" forState:UIControlStateNormal];
    
    if (!self.cameraPic.image) {
        
        //ボタンの文字色指定（最初うっすら透明）
        [self.myButton setTitleColor:[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:0.5] forState:UIControlStateNormal];
    } else {
        [self.myButton setTitleColor:[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        //メソッドとの紐付け
        [self.myButton addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    [self.ScrollView addSubview:self.myButton];
    
    
}

//tapされた時に反応するメソッド(SAVE)
-(void)tapBtn:(UIButton *)myButton{

    [UIView beginAnimations:@"animateViewrOn" context:nil];
    [UIView setAnimationDuration:0.3];
    
    if(self.isVisible == NO){
        self.myTable.frame = CGRectMake(0, self.view.bounds.size.height-270, self.view.bounds.size.width, 270);
        self.isVisible = YES;
    }else{
        
        [self downObjects];
    }
    
    [UIView commitAnimations];
    
//     MyEventsTableViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MyEventsTableViewController"];
//    
//    [self presentViewController:controller animated:YES completion: nil]; //モーダルで呼び出す
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // Table Viewの行数を返す
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [userDefault objectForKey:@"challenges"];
    
    
    NSMutableArray *challengesNow = [NSMutableArray new];
    for (NSDictionary *dic in ary) {
        if ([[dic valueForKey:@"type"] isEqualToString:@"now"]) {
            [challengesNow addObject:dic];
        }
    }
    self.challengesNow = challengesNow;
    
    return [challengesNow count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //staticで定数宣言　中身を変更したくないため static:静的
    static NSString *CellIdentifier = @"Cell";
    
    //再利用可能なCellオブジェクトを作成
    UITableViewCell *cell = [self.myTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.challengesNow valueForKey:@"title"][indexPath.row]];
    
    NSLog (@"ろぐ%@",cell.textLabel.text);
    return cell;
}

//行が押されたときに発動するメソッド(オブジェクトに付随するメソッド-delegateメソッド)
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        NSLog(@"行番号=%ld",(long)indexPath.row);
    
        // 遷移先画面に一覧から来たというフラグを渡す
        PersonalPageViewController *personalView;
        personalView.fromCameraView = YES;
 
        [UIView beginAnimations:@"animateViewrOn" context:nil];
        [UIView setAnimationDuration:0.3];
        [self downObjects];
        [UIView commitAnimations];
    
        PersonalPageViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalPageViewController"];
        [self.navigationController pushViewController:controller animated:YES]; //モーダルで呼び出す
    
}


-(void)downObjects{
    
    self.myTable.frame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0);
    self.isVisible = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarController:
(UITabBarController*)tabBarController
didSelectViewController:
(UIViewController*)CameraviewController{
    
    NSInteger sourceType = UIImagePickerControllerSourceTypeCamera;
    
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

- (IBAction)selectPhoto:(UIBarButtonItem *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    

}

- (IBAction)takePicture:(UIBarButtonItem *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)memoField:(id)sender {
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
    self.cameraPic.image = img_2;
    NSLog (@"%@",imgData);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    // イメージピッカーを隠す
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.cameraPic.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
