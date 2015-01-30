//
//  CameraViewController.m
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import "CameraViewController.h"
#import "MyEventsTableViewController.h"

@interface CameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>

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
    
    // textFieldはUITextField型の変数
    self.todaysText.delegate = self;
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (IBAction)returnText:(UITextField *)sender {
    
    if(self.camera.image){
        
        UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                  initWithTitle:@"どこのイベントに"
                                  delegate:self
                                  cancelButtonTitle:@"キャンセル"
                                  destructiveButtonTitle:@"保存先を選ぶ"
                                  otherButtonTitles:nil];
    [actionsheet showInView:self.actionsheetView];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)targetTextField {
    
    // textFieldを最初にイベントを受け取る対象から外すことで、
    // キーボードを閉じる。
    [targetTextField resignFirstResponder];
    
    return YES;
    
}




- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.camera.image = chosenImage;
    
    if(self.todaysText.text){
    UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                      initWithTitle:@"どこのイベントに"
                                      delegate:self
                                      cancelButtonTitle:@"キャンセル"
                                      destructiveButtonTitle:@"保存先を選ぶ"
                                      otherButtonTitles:nil];
        [actionsheet showInView:self.actionsheetView];
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    }
}



- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *clieckedButtonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    UIImage *img = self.camera.image;
    NSString *text = self.todaysText.text;


    if([clieckedButtonTitle isEqualToString:@"保存先を選ぶ"]){
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSData *picture = [NSData dataWithData:UIImagePNGRepresentation(img)];
    
        [userDefault setObject:picture forKey:@"takenPicture"];
        [userDefault setObject:text forKey:@"todaysNote"];
    
        MyEventsTableViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MyEventsTableViewController"];
        [self presentViewController:controller animated:YES completion: nil]; //モーダルで呼び出す
        
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
