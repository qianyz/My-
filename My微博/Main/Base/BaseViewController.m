//
//  BaseViewController.m
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeManager.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "ThemeButton.h"
#import "ThemeLabel.h"
#import "ThemeImageView.h"
#import "UIProgressView+AFNetworking.h"
@interface BaseViewController ()

@end

@implementation BaseViewController


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
     ];
}

//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
//    }
//    
//    return self;
//}
- (void)setBgImage{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadImage) name:kThemeDidChangeNotificationName object:nil];
    
    [self _loadImage];
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
//    [self setNavItem];
}

-(void)setNavItem
{
    
    //左边按钮
    ThemeButton *btn1 = [ThemeButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 80, 30);
    [btn1 setNormalImageName:@"button_title.png"];
    [btn1 addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    
    ThemeImageView *img1 = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    img1.imageName = @"group_btn_all_on_title.png";
    [btn1 addSubview:img1];
    
    ThemeLabel *label1 = [[ThemeLabel alloc]initWithFrame:CGRectMake(30, 0, 40, 30)];
    label1.text = @"设置";
    label1.colorName = @"More_Item_Text_color";
    [btn1 addSubview:label1];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    //右边按钮
    ThemeButton *btn2 = [ThemeButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 30, 30);
    [btn2 setNormalImageName:@"button_m.png"];
    [btn2 addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    
    ThemeImageView *img2 = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    img2.imageName = @"button_icon_plus.png";
    [btn2 addSubview:img2];

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItem = rightBtn;
}


-(void)setAction
{
    MMDrawerController *mmDrawer = self.mm_drawerController;
    [mmDrawer openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)editAction
{
    MMDrawerController *mmDrawer = self.mm_drawerController;
    [mmDrawer openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoading:(BOOL)show;
{
    if (_tipView == nil) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight/2-30, KScreenWidth, 20)];
        _tipView.backgroundColor = [UIColor clearColor];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.tag = 100;
        [_tipView addSubview:activityView];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"正在加载。。。";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        [label sizeToFit];
        
        [_tipView addSubview:label];
        
        label.left = (KScreenWidth-label.width)/2;
        activityView.right = label.left-5;
        
    }
    if (show) {
        UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_tipView viewWithTag:100];
        [activityView startAnimating];
        
        [self.view addSubview:_tipView];
    }else
    {
        if (_tipView.superview) {
            UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_tipView viewWithTag:100];
            [activityView startAnimating];
            
            [_tipView removeFromSuperview];
        }
    }
    
    
}

//第三方 MBProgressHUD

- (void)showHUD:(NSString *)title
{
    if (_hud == nil) {
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    [_hud show:YES];
    _hud.labelText = title;
    
    _hud.dimBackground = YES;

}

- (void)hideHUD
{
    [_hud hide:YES];

    
}

- (void)completeHUD:(NSString *)title
{
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.labelText = title;
    
    //持续1.5隐藏
    [_hud hide:YES afterDelay:1.5];

}

- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation
{
    if (_tipWindow == nil) {
        //01 创建window
        _tipWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar;
        _tipWindow.backgroundColor = [UIColor blackColor];
        
        //02 显示文字 label
        UILabel *toplabel = [[UILabel alloc]initWithFrame:_tipWindow.bounds];
        toplabel.backgroundColor = [UIColor clearColor];
        toplabel.textAlignment = NSTextAlignmentCenter;
        toplabel.font = [UIFont systemFontOfSize:13];
        toplabel.textColor = [UIColor whiteColor];
        toplabel.tag = 100;
        [_tipWindow addSubview:toplabel];
        
        //03 进度条
        UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        progressView.frame = CGRectMake(0, 20-3, KScreenWidth, 5);
        progressView.tag = 101;
        progressView.progress = 0.0;
        [_tipWindow addSubview:progressView];
        
        
    }
    
    UILabel *tpLabel = (UILabel*)[_tipWindow viewWithTag:100];
    tpLabel.text = title;
    
    
    UIProgressView *progressView = (UIProgressView *)[_tipWindow viewWithTag:101];
    
    
    if (show) {
        _tipWindow.hidden = NO;
        
        if (operation != nil) {
            progressView.hidden = NO;
            [progressView setProgressWithUploadProgressOfOperation:operation animated:YES];
        }else{
            progressView.hidden = YES;
        }
        
    }else{
        
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1];
    }
  
}

- (void)removeTipWindow{
    _tipWindow.hidden = YES;
    _tipWindow = nil;
    
}

@end
