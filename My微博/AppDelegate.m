//
//  AppDelegate.m
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "SinaWeibo.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
@interface AppDelegate ()<SinaWeiboDelegate,SinaWeiboRequestDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    MainTabBarController *mainTabB = [[MainTabBarController alloc]init];
    LeftViewController *leftVC = [[LeftViewController alloc]init];
    RightViewController *rightVC = [[RightViewController alloc]init];
    MMDrawerController *mmdrawer = [[MMDrawerController alloc]initWithCenterViewController:mainTabB leftDrawerViewController:leftVC rightDrawerViewController:rightVC];
    
    [mmdrawer setMaximumLeftDrawerWidth:150];
    [mmdrawer setMaximumRightDrawerWidth:60];
    
    [mmdrawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [mmdrawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [mmdrawer
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];

    self.window.rootViewController = mmdrawer;
    
    
    
    
    
    
    
    
    self.sinaWeibo = [[SinaWeibo alloc]initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"xxSinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        self.sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        self.sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        self.sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)storeAuthData
{
    
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.sinaWeibo.accessToken, @"AccessTokenKey",
                              self.sinaWeibo.expirationDate, @"ExpirationDateKey",
                              self.sinaWeibo.userID, @"UserIDKey",
                              self.sinaWeibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"xxSinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"xxSinaWeiboAuthData"];
}

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo;
{
    NSLog(@"登陆成功");
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"xxxLogin" object:nil];
    [self storeAuthData];
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo;
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"xxxLogout" object:nil];

    [self removeAuthData];
    
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error;
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);

}
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error;
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);

}
@end
