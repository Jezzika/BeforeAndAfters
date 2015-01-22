//
//  NewPageViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *makeNewTitle;
@property (weak, nonatomic) IBOutlet UITextField *makeNewDetail;
@property (weak, nonatomic) IBOutlet UIImageView *beforeImageView;

@property (assign, nonatomic) NSArray *CellNames;

@property (strong, nonatomic) IBOutlet UITableView *setTableView;






- (IBAction)returnNewTitle:(id)sender;
- (IBAction)returnNewDetail:(id)sender;
- (IBAction)showCameraSheet:(id)sender;



@end
