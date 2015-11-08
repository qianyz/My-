//
//  WeiboCell.h
//  My微博
//
//  Created by mac on 15/10/12.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboView.h"
#import "WeiboViewFrameLayout.h"
@interface WeiboCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rePostLabel;
@property (weak, nonatomic) IBOutlet UILabel *srLabel;

@property(nonatomic,strong)WeiboViewFrameLayout *layout;

@property(nonatomic,strong)WeiboView *weiboView;


@end
