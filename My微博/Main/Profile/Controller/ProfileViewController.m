//
//  ProfileViewController.m
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ProfileViewController.h"
//#import "MyWeibo.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "MJRefresh.h"
#import "MyWeiboCell.h"

@interface ProfileViewController ()
{
    MyWeiboTableView *_myWeiboTableView;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTable];
    [self setNavItem];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];




}
-(void)createTable
{
    _myWeiboTableView = [[MyWeiboTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_myWeiboTableView];
    [self showHUD:@"正在加载..."];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"result = %@",result);
    NSArray *dicArray = [result objectForKey:@"statuses"];
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:dicArray.count];
    
    for (NSDictionary *dataDic in dicArray) {
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
        WeiboViewFrameLayout *layout = [[WeiboViewFrameLayout alloc]init];
        layout.model = model;
        
        [mArray addObject:layout];
        
    }
    [self completeHUD:@"加载完成"];

    _myWeiboTableView.weiboArray = mArray;
    [_myWeiboTableView reloadData];
    
}



@end
