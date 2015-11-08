//
//  DetailViewController.h
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
@interface DetailViewController : BaseViewController
@property(nonatomic,strong)WeiboModel *model;

@property(nonatomic,strong)NSMutableArray *data;


@end
