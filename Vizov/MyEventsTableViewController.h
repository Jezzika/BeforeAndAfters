//
//  MyEventsTableViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/27/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+FlatUI.h"
#import "UIBarButtonItem+FlatUI.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UIImage+FlatUI.h"
#import "NSString+Icons.h"
#import <FlatUIKit/UIColor+FlatUI.h>
#import "UITableViewCell+FlatUI.h"
#import "FUICellBackgroundView.h"

@interface MyEventsTableViewController : UITableViewController

@property (nonatomic) BOOL fromListView;

@property (strong, nonatomic) IBOutlet UITableView *myEventsTable;
- (IBAction)shareButton:(id)sender;

@end
