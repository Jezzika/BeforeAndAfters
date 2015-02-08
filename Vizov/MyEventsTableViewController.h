//
//  MyEventsTableViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/27/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEventsTableViewController : UITableViewController

@property (nonatomic) BOOL fromListView;

@property (strong, nonatomic) IBOutlet UITableView *myEventsTable;
- (IBAction)shareButton:(id)sender;

@end
