//
//  FriendsCell.m
//  My微博
//
//  Created by mac on 15/10/22.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "FriendsCell.h"
#import "UIImageView+WebCache.h"
@implementation FriendsCell


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    

    
    [_userImage sd_setImageWithURL:[NSURL URLWithString:_model.profile_image_url]];
    _nameLabel.text = _model.screen_name;
    _FollowersLabel.text = [NSString stringWithFormat:@"%@粉丝",_model.followers_count];
    
    
    
}

@end
