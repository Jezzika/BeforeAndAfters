//
//  ListTableViewController.h
//  Vizov
//
//  Created by MiriKunisada on 1/26/15.
//  Copyright (c) 2015 Miri Kunisada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) BOOL fromFirstView;


@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@property (strong, nonatomic) IBOutlet UITableView *doneListTableView;

@end
