//
//  BaseViewController.h
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperation.h"
@interface BaseViewController : UIViewController
{
    UIView *_tipView; //屏幕中央加载提示
    MBProgressHUD *_hud;
    UIWindow *_tipWindow;//在状态栏上显示 微博发送进度

}

-(void)setNavItem;
- (void)setBgImage;

- (void)showLoading:(BOOL)show;


//第三方 MBProgressHUD

- (void)showHUD:(NSString *)title;

- (void)hideHUD;
- (void)completeHUD:(NSString *)title;

//状态栏 提示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation;
@end
