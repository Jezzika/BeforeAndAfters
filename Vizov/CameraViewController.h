//
//  CameraViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *camera;

- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)returnText:(UITextField*)sender;


@property (strong, nonatomic) IBOutlet UIView *actionsheetView;
@property (strong, nonatomic) IBOutlet UITextField *todaysText;

@end
