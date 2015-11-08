//
//  UserView.m
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "UserView.h"
#import "UIImageView+WebCache.h"
@implementation UserView

-(void)setModel:(WeiboModel *)model
{
    if (_model != model) {
        _model = model;
        [self setNeedsLayout];
        
    }
}

-(void)layoutSubviews
{
    _userImageView.layer.masksToBounds = YES;

    [_userImageView sd_setImageWithURL:[NSURL URLWithString: _model.userModel.profile_image_url]];
    _userNameLabel.text = _model.userModel.screen_name;
    
    _sourceLabel.text = _model.source;

    
    
    
    
}

@end
