//
//  BaseNavController.m
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManager.h"
@interface BaseNavController ()

@end

@implementation BaseNavController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
     ];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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
    
    UIImage *image = [manager getThemeImage:@"mask_titlebar64.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    UIColor *color = [manager getThemeColor:@"Mask_Title_color"];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadImage];

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
