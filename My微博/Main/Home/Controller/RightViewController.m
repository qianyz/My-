//
//  RightViewController.m
//  My微博
//
//  Created by mac on 15/10/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"
#import "SendViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "BaseNavController.h"
#import "LocViewController.h"
@interface RightViewController ()

@end

@implementation RightViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
     ];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    
    return self;
}

-(void)themeDidChange:(NSNotification *)notification
{
    [self _loadImage];
}

-(void)_loadImage
{
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _loadImage];
    
    NSArray *imageNames = @[@"newbar_icon_1.png",
                            @"newbar_icon_2.png",
                            @"newbar_icon_3.png",
                            @"newbar_icon_4.png",
                            @"newbar_icon_5.png"];
    
    // 创建主题按钮
    for (int i = 0; i < imageNames.count; i++) {
        // 创建
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(20, 64 + i * (40 + 10), 40, 40)];
        button.normalImageName = imageNames[i];
        
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }


}

-(void)buttonAction:(UIButton *)btn
{
    if (btn.tag == 0) {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            SendViewController *sendVC = [[SendViewController alloc]init];
            sendVC.title = @"发送微博";
            
            BaseNavController *baseNC = [[BaseNavController alloc]initWithRootViewController:sendVC];
            [self.mm_drawerController presentViewController:baseNC animated:YES completion:nil];
            
            
        }];
    }else if(btn.tag == 4){
        
        // 附近地点
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            
            
            LocViewController *vc = [[LocViewController alloc] init];
            vc.title = @"附近商圈";
            
            // 创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:vc];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
