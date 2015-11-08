//
//  WeiboTableView.h
//  My微博
//
//  Created by mac on 15/10/12.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *weiboArray;
@end
