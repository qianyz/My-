//
//  DetailViewController.m
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableView.h"
#import "UserView.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "CommentModel.h"
#import "MJRefresh.h"

@interface DetailViewController ()<SinaWeiboRequestDelegate>
{
    DetailTableView *_detailTableView;
    SinaWeiboRequest *_request;
    
}
@end

@implementation DetailViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博详情";
    [self createTable];
    [self loadData];
}

-(void)createTable
{
    _detailTableView = [[DetailTableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _detailTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_detailTableView];
    _detailTableView.model = _model;
    
    _detailTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];

}



-(void)loadData
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    
    NSString *weiboId = self.model.weiboIdStr;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboId forKey:@"id"];
    _request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    _request.tag = 100;

}

-(void)_loadMoreData
{
    NSString *weiboId = [self.model.weiboId stringValue];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboId forKey:@"id"];
    
    
    //设置max_id 分页加载
    CommentModel *cm = [self.data lastObject];
    if (cm == nil) {
        return;
    }
    NSString *lastID = cm.idstr;
    [params setObject:lastID forKey:@"max_id"];
    
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    _request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    _request.tag = 102;
    
    

}
- (void)viewWillDisappear:(BOOL)animated{
    //当界面弹出的时候，断开网络链接
    [_request disconnect];
    
}


-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"网络接口 请求成功");
    
    NSArray *array = [result objectForKey:@"comments"];
    
    NSMutableArray *comentModelArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    for (NSDictionary *dataDic in array) {
        NSLog(@"--------------------------%@",dataDic);
        CommentModel *commentModel = [[CommentModel alloc]initWithDataDic:dataDic];
        [comentModelArray addObject:commentModel];
    }

    self.data = comentModelArray;

    
    
    if (_data != 0) {
        self.data = comentModelArray;
        
    }else if(request.tag ==102){//更多数据
        [_detailTableView.footer endRefreshing];
        if (comentModelArray.count > 1) {
            [comentModelArray removeObjectAtIndex:0];
            [self.data addObjectsFromArray:comentModelArray];
        }else{
            return;
        }
    }
    
    _detailTableView.commentsArray = self.data;
    _detailTableView.commentDic = result;
    [_detailTableView reloadData];
    
    [_detailTableView.footer endRefreshing];

}


@end
