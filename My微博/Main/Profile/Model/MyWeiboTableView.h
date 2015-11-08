//
//  MyWeiboTableView.h
//  My微博
//
//  Created by mac on 15/10/14.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MyWeibo.h"
@interface MyWeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *weiboArray;
//@property(nonatomic,strong)MyWeibo *myWeibo;
@end
