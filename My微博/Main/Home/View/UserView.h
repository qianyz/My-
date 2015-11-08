//
//  UserView.h
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
@interface UserView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property(nonatomic,strong)WeiboModel *model;
@end
