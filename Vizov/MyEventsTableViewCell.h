//
//  MyEventsTableViewCell.h
//  Vizov
//
//  Created by MiriKunisada on 2/8/15.
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

@interface MyEventsTableViewCell : UITableViewCell

- (void)setData:(NSMutableDictionary *)eventDaysArySet;
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *setMemo;

@end
