//
//  WeiboView.m
//  My微博
//
//  Created by mac on 15/10/12.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+WebCache.h"
#import "ThemeManager.h"
@implementation WeiboView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubView];

    }
    return self;
}

-(void)_createSubView
{
    _textLabel = [[WXLabel alloc]initWithFrame:CGRectZero];
    _sourceLabel = [[WXLabel alloc]initWithFrame:CGRectZero];
    _textLabel.wxLabelDelegate = self;
    _sourceLabel.wxLabelDelegate = self;
    _textLabel.linespace = 5;
    _sourceLabel.linespace = 5;
    
    _textLabel.font = [UIFont systemFontOfSize:15];
    _sourceLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];

    
    _imgView = [[ZoomImageView alloc]init];
    _bgImageView = [[ThemeImageView alloc]initWithFrame:CGRectZero];
    
    _bgImageView.leftCapWidth = 30;
    _bgImageView.topCapHeight = 30;
    
    
    [self addSubview:_bgImageView];
    [self addSubview:_textLabel];
    [self addSubview:_sourceLabel];
    [self addSubview:_imgView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    
}

-(void)setLayout:(WeiboViewFrameLayout *)layout
{
    if (_layout != layout) {
        _layout = layout;
        [self setNeedsLayout];
        
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _textLabel.font =   [UIFont systemFontOfSize: FontSize_Weibo(_layout.isDetail)] ;
    _sourceLabel.font =  [UIFont systemFontOfSize: FontSize_ReWeibo(_layout.isDetail)] ;
    
    WeiboModel *model = _layout.model;
    
    _textLabel.frame = _layout.textFrame;
    _textLabel.text = model.text;
    
    //是否转发
    if (model.reWeiboModel != nil) {
        _bgImageView.hidden = NO;
        _sourceLabel.hidden = NO;
        
        _sourceLabel.frame = _layout.srTextFrame;
        _sourceLabel.text = model.reWeiboModel.text;
        
        _bgImageView.frame = _layout.bgImageFrame;
        _bgImageView.imageName = @"timeline_rt_border_9.png";
        
        NSString *str = model.reWeiboModel.thumbnailImage;
        if (str == nil) {
            _imgView.hidden = YES;
        }
        else
        {
            _imgView.fullImageUrlStr = model.reWeiboModel.originalImage;
            _imgView.hidden = NO;
            _imgView.frame = _layout.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:str]];
        }
        
        
    }else//非转发
    {
        _bgImageView.hidden = YES;
        _sourceLabel.hidden = YES;
        
        
        NSString *str = model.thumbnailImage;
        if (str == nil) {
            _imgView.hidden = YES;
        }
        else
        {
            _imgView.fullImageUrlStr = model.originalImage;

            _imgView.hidden = NO;
            _imgView.frame = _layout.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:str]];
        }
        
    }
    
    
    if (_imgView.hidden == NO) {
        NSString *extension;
        UIImageView *iconView = _imgView.iconView;
        iconView.frame = CGRectMake(_imgView.width-24, _imgView.height-15, 24, 14);
        //获取url后缀 查看是否是gif
        if (model.reWeiboModel != nil) {
            extension = [model.reWeiboModel.thumbnailImage pathExtension];
        }else
        {
            extension = [model.thumbnailImage pathExtension];
            
        }
        
        if ([extension isEqualToString:@"gif"]) {
            iconView.hidden = NO;
            _imgView.isGif = YES;
        }else
        {
            iconView.hidden = YES;
            _imgView.isGif = NO;
        }
        
        
        
        
    }
    
}

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    // https://www.baidu.com/hello/jlasjdlf/1.json
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}



- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel
{
    return [[ThemeManager shareInstance]getThemeColor:@"Link_color"];
}

- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{
    return  [UIColor blueColor];
}




-(void)themeDidChange:(NSNotification *)nofication
{
    _textLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
}


@end
