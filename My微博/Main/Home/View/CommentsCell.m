//
//  CommentsCell.m
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CommentsCell.h"
#import "ThemeManager.h"
#import "UIImageView+WebCache.h"
@implementation CommentsCell


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _commentLabel = [[WXLabel alloc]initWithFrame:CGRectZero];
        _commentLabel.font = [UIFont systemFontOfSize:14.0f];
        _commentLabel.linespace = 5;

        _commentLabel.wxLabelDelegate = self;
        [self.contentView addSubview:_commentLabel];

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //头像
    NSString *urlstring = _commentModel.user.profile_image_url;
    [_image sd_setImageWithURL:[NSURL URLWithString:urlstring]];
    //昵称
    
    _nameLabel.text = _commentModel.user.screen_name;
    
    //评论内容
    CGFloat height = [WXLabel getTextHeight:14.0f
                                      width:240
                                       text:_commentModel.text
                                  linespace:5];
    
    _commentLabel.frame = CGRectMake(_image.right+10, _nameLabel.bottom+5, KScreenWidth-70, height);
//    _commentLabel.height = height;
    
    _commentLabel.text = _commentModel.text;
    
    
}

//返回一个正则表达式，通过此正则表达式查找出需要添加超链接的文本
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    //需要添加连接的字符串的正则表达式：@用户、http://... 、 #话题#
    NSString *regex1 = @"@\\w+"; //@"@[_$]";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#^#+#";  //\w 匹配字母或数字或下划线或汉字
    
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    
    UIColor *linkColor = [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
    return linkColor;
}

//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    return [UIColor darkGrayColor];
}


//计算评论单元格的高度
+ (float)getCommentHeight:(CommentModel *)commentModel {
    CGFloat height = [WXLabel getTextHeight:14.0f
                                      width:KScreenWidth-70
                                       text:commentModel.text
                                  linespace:5];
    
    return height+80;
}


@end
