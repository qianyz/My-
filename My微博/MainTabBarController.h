//
//  MainTabBarController.h
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavController.h"
#import "SinaWeibo.h"
@interface MainTabBarController : UITabBarController<SinaWeiboDelegate,SinaWeiboRequestDelegate>

@end
