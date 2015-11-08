//
//  ThemeImageView.m
//  My微博
//
//  Created by mac on 15/10/9.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
        
    }
    return self;
}
-(void)themeDidChange:(NSNotification *)notification
{
    [self loadImage];
    
}

-(void)setImageName:(NSString *)imageName
{
    if (![_imageName isEqualToString:imageName]) {
        _imageName = [imageName copy];
        [self loadImage];
    }
}

-(void)loadImage
{
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:self.imageName];
    UIImage *image2 = [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapHeight];
    
    self.image = image2;
}
@end
