//
//  NewPageViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "NewPageViewController.h"

@interface NewPageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource>


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
    //データを書き込む
    NSUserDefaults *myDefaultsTitle = [NSUserDefaults standardUserDefaults];
    [myDefaultsTitle setObject:self.makeNewTitle.text forKey:@"myTitle"];
    [myDefaultsTitle synchronize];
    
    //データを呼び出す
    NSString *tStr = [myDefaultsTitle stringForKey:@"myTitle"];
    NSLog(@"%@",tStr);
}

- (IBAction)returnNewDetail:(id)sender {
    //データを書き込む
    NSUserDefaults *myDefaultsDetail = [NSUserDefaults standardUserDefaults];
    [myDefaultsDetail setObject:self.makeNewDetail.text forKey:@"myDetail"];
    [myDefaultsDetail synchronize];
    
    //データを呼び出す
    NSString *dStr = [myDefaultsDetail stringForKey:@"myDetail"];
    NSLog(@"%@",dStr);

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

//設定画面の画面遷移
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[NSString stringWithFormat:@"%d", indexPath.row] forKey:@"num"];
    
    //[self performSegueWithIdentifier:@"rowNumber" sender:self];
}



@end
