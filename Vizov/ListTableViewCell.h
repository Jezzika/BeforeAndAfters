//
//  ListTableViewCell.h
//  Vizov
//
//  Created by MiriKunisada on 2/6/15.
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

@interface ListTableViewCell : UITableViewCell

- (void)setData:(NSMutableArray *)challengesDone;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *beforeImage;
@property (strong, nonatomic) IBOutlet UIImageView *afterImage;
@property (weak, nonatomic) IBOutlet UILabel *totalDays;
@property (weak, nonatomic) IBOutlet UILabel *beforeLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterLabel;
@property (weak, nonatomic) IBOutlet UIView *afterView;
@property (weak, nonatomic) IBOutlet UIView *beforeView;

@end

