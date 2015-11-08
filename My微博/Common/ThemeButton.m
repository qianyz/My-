//
//  ThemeButton.m
//  My微博
//
//  Created by mac on 15/10/9.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
@implementation ThemeButton

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
//    [self loadbgImage];
}

-(void)setNormalImageName:(NSString *)normalImageName
{
    if (![_normalImageName isEqualToString:normalImageName]) {
        _normalImageName = [normalImageName copy];
        [self loadImage];
    }
}
//-(void)setbgImageName:(NSString *)bgImageName
//{
//    if (![_bgImageName isEqualToString:bgImageName]) {
//        _bgImageName = [bgImageName copy];
//        [self loadbgImage];
//    }
//}
//-(void)loadbgImage
//{
//    ThemeManager *manager = [ThemeManager shareInstance];
//    UIImage *image = [manager getThemeImage:self.normalImageName];
//    if (image != nil) {
//        [self setBackgroundImage:image forState:UIControlStateNormal];
//        
//    }
//}

-(void)loadImage
{
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:self.normalImageName];
    if (image != nil) {
        [self setImage:image forState:UIControlStateNormal];
        
    }
}

@end
