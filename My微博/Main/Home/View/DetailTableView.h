//
//  DetailTableView.h
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserView.h"
#import "WeiboView.h"
#import "WeiboViewFrameLayout.h"
@interface DetailTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_tablrHeaderView;

}
@property(nonatomic,strong)NSArray *commentsArray;
@property(nonatomic,strong)UserView *userView;
@property(nonatomic,strong)WeiboView *weiboView;
@property(nonatomic,strong)WeiboModel *model;
//@property(nonatomic,strong)WeiboViewFrameLayout *layout;
@property(nonatomic,strong)NSDictionary *commentDic;

@end
