//
//  ListTableViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/26/15.
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

@interface ListTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) BOOL fromFirstView;
@property (strong, nonatomic) IBOutlet UITableView *listTableView;

- (IBAction)deleteItemBtn:(id)sender;

@end
