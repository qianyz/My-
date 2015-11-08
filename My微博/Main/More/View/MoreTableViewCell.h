//
//  MoreTableViewCell.h
//  My微博
//
//  Created by mac on 15/10/9.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
@interface MoreTableViewCell : UITableViewCell
@property(nonatomic,strong)ThemeLabel *themetextLabel;
@property(nonatomic,strong)ThemeLabel *themedetailLabel;

@property(nonatomic,strong)ThemeImageView*themeimageView;
@end
