//
//  CameraViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *cameraPic;

@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;


- (IBAction)selectPhoto:(UIBarButtonItem *)sender;
- (IBAction)takePicture:(UIBarButtonItem *)sender;

- (IBAction)memoField:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *actionsheetView;


@end
