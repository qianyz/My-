//
//  MyWeiboTopCell.h
//  My微博
//
//  Created by mac on 15/10/15.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewFrameLayout.h"
#import "WeiboView.h"
#import "SinaWeiboRequest.h"
@interface MyWeiboTopCell : UITableViewCell<SinaWeiboRequestDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;
@property (weak, nonatomic) IBOutlet UILabel *jianjieLabel;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@property(nonatomic,strong)WeiboViewFrameLayout *layout;
@property(nonatomic,strong)UILabel *numlabel1;
@property(nonatomic,strong)UILabel *numlabel2;

//@property(nonatomic,strong)WeiboView *weiboView;
@end
