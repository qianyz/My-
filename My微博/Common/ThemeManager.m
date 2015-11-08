//
//  ThemeManager.m
//  My微博
//
//  Created by mac on 15/10/9.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager
{
    NSDictionary *_themeConfig;
    NSDictionary *_colorConfig;
}
+(ThemeManager*)shareInstance
{
    static ThemeManager *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[[self class] alloc]init];
    });
    return instance;
    
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _themeName = [[NSUserDefaults standardUserDefaults]objectForKey:kThemeName];
        if (_themeName.length == 0) {
            _themeName = @"Cat";
        }
        
        NSString *configpath = [[NSBundle mainBundle]pathForResource:@"theme" ofType:@"plist"];
        _themeConfig = [NSDictionary dictionaryWithContentsOfFile:configpath];
        
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return self;
    
}

-(void)setThemeName:(NSString *)themeName
{
    if (![_themeName isEqualToString:themeName]) {
        _themeName = [themeName copy];
        [[NSUserDefaults standardUserDefaults]setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kThemeDidChangeNotificationName object:nil];
    }
}

-(UIColor*)getThemeColor:(NSString *)colorName
{
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"] floatValue];
    CGFloat g = [rgbDic[@"G"] floatValue];
    CGFloat b = [rgbDic[@"B"] floatValue];
    CGFloat alpha = 1;
    
    if (rgbDic[@"alpha"] != nil) {
        alpha = [rgbDic[@"alpha"] floatValue];

    }
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    
    return color;

}

-(UIImage *)getThemeImage:(NSString*)imageName
{
    NSString *themePath = [self themePath];
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

-(NSString *)themePath
{
    NSString *respath = [[NSBundle mainBundle]resourcePath];
    NSString *pathSufix = [_themeConfig objectForKey:self.themeName];
    NSString *path = [respath stringByAppendingPathComponent:pathSufix];
    return path;
}

@end
