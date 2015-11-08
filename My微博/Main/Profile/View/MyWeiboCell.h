//
//  MyWeiboCell.h
//  My微博
//
//  Created by mac on 15/10/14.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewFrameLayout.h"
#import "WeiboView.h"
@interface MyWeiboCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rePostLabel;
@property (weak, nonatomic) IBOutlet UILabel *srLabel;

@property(nonatomic,strong)WeiboViewFrameLayout *layout;

@property(nonatomic,strong)WeiboView *weiboView;
@end
