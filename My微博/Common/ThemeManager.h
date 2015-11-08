//
//  ThemeManager.h
//  My微博
//
//  Created by mac on 15/10/9.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kThemeDidChangeNotificationName  @"kThemeDidChangeNotificationName"
#define kThemeName @"kThemeName"
@interface ThemeManager : NSObject
@property(nonatomic,copy)NSString*themeName;//主题名字
+(ThemeManager*)shareInstance;//单例
-(UIImage *)getThemeImage:(NSString*)imageName;
-(UIColor*)getThemeColor:(NSString *)colorName;

@end
