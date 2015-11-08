//
//  MyWeiboCell.m
//  My微博
//
//  Created by mac on 15/10/14.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MyWeiboCell.h"
#import "UIImageView+WebCache.h"
@implementation MyWeiboCell

- (void)awakeFromNib {
    [self _createSubView];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)_createSubView
{
    _weiboView = [[WeiboView alloc]init];
    [self.contentView addSubview:_weiboView];
}

-(void)setLayout:(WeiboViewFrameLayout *)layout
{
    if (_layout != layout) {
        _layout = layout;
        _weiboView.layout = _layout;
        [self setNeedsLayout];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    WeiboModel *_model = _layout.model;
    
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url]];
    _nickNameLabel.text = _model.userModel.screen_name;
    
    _commentLabel.text = [NSString stringWithFormat:@"评论:%@",_model.commentsCount];
    
    _rePostLabel.text = [NSString stringWithFormat:@"转发:%@",_model.repostsCount];
    
    _srLabel.text = _model.source;
    
    _weiboView.frame = _layout.frame;
    
    
}



@end
