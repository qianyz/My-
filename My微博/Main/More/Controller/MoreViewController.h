//
//  MoreViewController.h
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MoreViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
