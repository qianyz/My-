//
//  FriendsCell.h
//  My微博
//
//  Created by mac on 15/10/22.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewFrameLayout.h"
#import "FriendsModel.h"
@interface FriendsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *FollowersLabel;
@property(nonatomic,strong)FriendsModel *model;

@end
