//
//  WeiboViewFrameLayout.m
//  My微博
//
//  Created by mac on 15/10/12.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "WeiboViewFrameLayout.h"

@implementation WeiboViewFrameLayout
-(void)setModel:(WeiboModel *)model
{
    if (_model != model) {
        _model = model;
        
        [self _layoutFrame];
    }
}

//-(void)_layoutFrame
//{
//    _textFrame = CGRectMake(5, 40, 280, 60);
//    _srTextFrame = CGRectMake(35, 105, 280, 70);
//    _imgFrame = CGRectMake(40, 160, 80, 80);
//    _bgImageFrame = CGRectMake(5, 80, 350, 160);
//    _frame = CGRectMake(0, 20,350, 230);
//
//
//
//}

-(void)_layoutFrame
{
    
    CGFloat weiboFontSize = FontSize_Weibo(self.isDetail);
    CGFloat reWeiboFontSize = FontSize_ReWeibo(self.isDetail);
    
    if (self.isDetail) {
        self.frame = CGRectMake(0, 0, KScreenWidth, 0);
    }else{
        self.frame = CGRectMake(55, 40, KScreenWidth-65, 0);
        
    }
    //1>计算微博内容的宽度
    CGFloat textWidth = CGRectGetWidth(self.frame)-20;
    //2>计算微博内容的高度
    NSString *text = self.model.text;
    CGFloat textHeight = [WXLabel getTextHeight:weiboFontSize width:textWidth text:text linespace:5.0];
    self.textFrame = CGRectMake(10, 0, textWidth, textHeight);
    
    //3.原微博的内容frame
    if (self.model.reWeiboModel != nil) {
        NSString *reText = self.model.reWeiboModel.text;
        
        //1>宽度
        CGFloat reTextWidth = textWidth-20;
        //2>高度
        
        CGFloat textHeight = [WXLabel getTextHeight:reWeiboFontSize width:reTextWidth text:reText linespace:5.0];
        
        //3>Y坐标
        CGFloat Y = CGRectGetMaxY(self.textFrame)+10;
        self.srTextFrame = CGRectMake(20, Y, reTextWidth, textHeight);
        
        //4.原微博的图片
        NSString *thumbnailImage = self.model.reWeiboModel.thumbnailImage;
        if (thumbnailImage != nil) {
            
            CGFloat Y = CGRectGetMaxY(self.srTextFrame)+10;
            CGFloat X = CGRectGetMinX(self.srTextFrame);
            if (self.isDetail) {
                self.imgFrame = CGRectMake(X, Y, CGRectGetWidth(self.frame)-20, 160);
            } else {
                self.imgFrame = CGRectMake(X, Y, 80, 80);
            }
        }
        
        //4.原微博的背景
        CGFloat bgX = CGRectGetMinX(self.textFrame);
        CGFloat bgY = CGRectGetMaxY(self.textFrame);
        CGFloat bgWidth = CGRectGetWidth(self.textFrame);
        CGFloat bgHeight = CGRectGetMaxY(self.srTextFrame);
        if (thumbnailImage != nil) {
            bgHeight = CGRectGetMaxY(self.imgFrame);
        }
        bgHeight -= CGRectGetMaxY(self.textFrame);
        bgHeight += 10;
        
        self.bgImageFrame = CGRectMake(bgX, bgY, bgWidth, bgHeight);
        
    } else {
        //微博图片
        NSString *thumbnailImage = self.model.thumbnailImage;
        if (thumbnailImage != nil) {
            
            CGFloat imgX = CGRectGetMinX(self.textFrame);
            CGFloat imgY = CGRectGetMaxY(self.textFrame)+10;
            
            
            if (self.isDetail) {
                self.imgFrame = CGRectMake(imgX , imgY, CGRectGetWidth(self.frame)-40, 160);
            } else {
                self.imgFrame = CGRectMake(imgX , imgY, 80, 80);
            }

        }
        
    }
    
    //计算微博视图的高度：微博视图最底部子视图的Y坐标
    CGRect f = self.frame;
    if (self.model.reWeiboModel != nil) {
        f.size.height = CGRectGetMaxY(_bgImageFrame);
    }
    else if(self.model.thumbnailImage != nil) {
        f.size.height = CGRectGetMaxY(_imgFrame);
    }
    else {
        f.size.height = CGRectGetMaxY(_textFrame);
    }
    self.frame = f;

    
}




@end
