//
//  MainTabBarController.m
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MainTabBarController.h"
#import "Common.h"
#import "ThemeImageView.h"
#import "ThemeButton.h"
#import "ThemeLabel.h"
#import "AppDelegate.h"
@interface MainTabBarController ()
{
    ThemeImageView *_selectImageView;
    ThemeImageView *_badgeImageView;
    ThemeLabel *_badgeLabel;
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubController];
    [self creatTabBar];
    
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatTabBar
{
    //移除系统的UITabBarButton
    for (UIView *view in self.tabBar.subviews) {
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    ThemeImageView *bgImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 49)];
//    bgImageView.image = [UIImage imageNamed:@"Skins/cat/mask_navbar.png"];
    bgImageView.imageName = @"mask_navbar.png";
    [self.tabBar addSubview:bgImageView];
    
    _selectImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/4, 49)];
//    _selectImageView.image = [UIImage imageNamed:@"Skins/cat/home_bottom_tab_arrow.png"];
    _selectImageView.imageName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectImageView];
    
    CGFloat BWidth = KScreenWidth/4;
//    NSArray *btnImageArray = @[@"Skins/cat/home_tab_icon_1.png",
//                               @"Skins/cat/home_tab_icon_2.png",
//                               @"Skins/cat/home_tab_icon_3.png",
//                               @"Skins/cat/home_tab_icon_4.png",
//                               @"Skins/cat/home_tab_icon_5.png"];
    NSArray *btnImageArray = @[@"home_tab_icon_1.png",
                               @"home_tab_icon_3.png",
                               @"home_tab_icon_4.png",
                               @"home_tab_icon_5.png"];
    
    for (int i = 0; i<4; i++) {
        ThemeButton *button = [[ThemeButton alloc]initWithFrame:CGRectMake(i*BWidth, 0, BWidth, 49)];
//        [button setImage:[UIImage imageNamed:btnImageArray[i]] forState:UIControlStateNormal];
        [button setNormalImageName:btnImageArray[i]];
        button.tag = i;
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
        
    }
    
}

-(void)selectAction:(UIButton *)sender
{
    [UIView animateWithDuration:.5 animations:^{
        _selectImageView.center = sender.center;
    }];
    self.selectedIndex = sender.tag;
}

-(void)creatSubController
{
    NSArray *names = @[@"Home",@"Discover",@"Profile",@"More"];
    NSMutableArray *NavArray = [[NSMutableArray alloc]initWithCapacity:4];
    
    for (int i = 0; i<4; i++) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:names[i] bundle:nil];
        BaseNavController *baseNV = [storyBoard instantiateInitialViewController];
        [NavArray addObject:baseNV];
        
    }
    self.viewControllers = NavArray;
}

-(void)timerAction
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
    
}

-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    //number_notify_9.png
    //Timeline_Notice_color
    
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    
    CGFloat tabBarButtonWidth = KScreenWidth/4;
    if (_badgeImageView == nil) {
        _badgeImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(tabBarButtonWidth-32, 0, 32, 32)];
        _badgeImageView.imageName = @"number_notify_9.png";
        [self.tabBar addSubview:_badgeImageView];
        
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeImageView.bounds];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font =[UIFont systemFontOfSize:13];
        _badgeLabel.colorName = @"Timeline_Notice_color";
        [_badgeImageView addSubview:_badgeLabel];
    }
    if (count > 0) {
        _badgeImageView.hidden = NO;
        if (count > 99) {
            count = 99;
        }
        _badgeLabel.text = [NSString stringWithFormat:@"%li",count];
    }else
    {
        _badgeImageView.hidden = YES;
    }
    
    
    
    
    
    
    
    
    
    
    
}



@end
