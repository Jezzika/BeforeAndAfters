//
//  FirstViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/16/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UIImage+FlatUI.h"
#import "NSString+Icons.h"
#import <FlatUIKit/UIColor+FlatUI.h>
#import "UINavigationBar+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UITableViewCell+FlatUI.h"
#import "FUICellBackgroundView.h"
#import "UITabBar+FlatUI.h"


@interface FirstViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnItem;
@property (weak, nonatomic) IBOutlet UINavigationItem *naviItem;
@property (nonatomic) NSMutableArray *challengesNow;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteItem;
- (IBAction)deleteItemBtn:(id)sender;



@end
