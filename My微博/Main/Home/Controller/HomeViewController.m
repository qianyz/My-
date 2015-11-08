//
//  HomeViewController.m
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "ThemeManager.h"
#import "WeiboModel.h"
#import "WeiboTableView.h"
#import "WeiboViewFrameLayout.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    WeiboTableView *_weiboTabel;
    NSMutableArray *_data;
    ThemeImageView *_topImageView;
    ThemeLabel *_label;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];
    [self createTable];
    [self setNavItem];
    [self _loadWeiboData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)createTable
{
    _weiboTabel = [[WeiboTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.view addSubview:_weiboTabel];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 70)];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];

    
    _weiboTabel.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _weiboTabel.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
}

-(void)_loadWeiboData
{
//    [self showLoading:YES];
    [self showHUD:@"正在加载..."];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    if (sinaWeibo.isLoggedIn) {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setObject:@"10" forKey:@"count"];
        SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                           params:params
                       httpMethod:@"GET"
                         delegate:self];
        
        request.tag = 100;
        return;
        
    }
    else[sinaWeibo logIn];

}
//下拉刷新
-(void)loadNewData
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@"10" forKey:@"count"];
    
    if (_data.count!=0) {
        WeiboViewFrameLayout *layoutFrame = _data[0];
        WeiboModel *model = layoutFrame.model;
        NSString *sinceID = model.weiboIdStr;
        [params setObject:sinceID forKey:@"since_id"];
    }
    SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                                                   params:params
                                               httpMethod:@"GET"
                                                 delegate:self];
    
    request.tag = 101;
    
}
//上拉更多
-(void)loadMoreData
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:@"10" forKey:@"count"];
    
    if (_data.count != 0) {
        WeiboViewFrameLayout *layoutFrame = [_data lastObject];
        WeiboModel *model = layoutFrame.model;
        NSString *maxId = model.weiboIdStr;
        [params setObject:maxId forKey:@"max_id"];
    }
    
    SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                                                   params:params
                                               httpMethod:@"GET"
                                                 delegate:self];
    
    request.tag = 102;

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
    
    
    if (request.tag == 100) {
        
//        [self showLoading:NO];
        [self completeHUD:@"加载完成"];

        _data = mArray;
    }else if (request.tag == 101){
        //下拉刷新
        if (_data == nil) {
            _data =mArray;
        }else{
            NSRange range = NSMakeRange(0, mArray.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_data insertObjects:mArray atIndexes:indexSet];
            
            [self addNewWeiboCount:mArray.count];
            
            
        }
        
        
    }else if (request.tag == 102){
        //上拉更多
        if (_data == nil) {
            _data =mArray;
        }else{
            [_data removeLastObject];
            [_data addObjectsFromArray:mArray];
            
        }
        
    }
    
    if (_data != 0) {
        _weiboTabel.weiboArray = _data;
        [_weiboTabel reloadData];

    }
//    _weiboTabel.weiboArray = _data;
//    [_weiboTabel reloadData];
    [_weiboTabel.header endRefreshing];
    [_weiboTabel.footer endRefreshing];
}

-(void)addNewWeiboCount:(NSInteger)count;
{
    if (_topImageView == nil) {
        _topImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, -40, KScreenWidth-10, 40)];
        _topImageView.imageName = @"timeline_notify.png";
        
        [self.view addSubview:_topImageView];
        
        _label = [[ThemeLabel alloc]initWithFrame:_topImageView.bounds];
        _label.colorName = @"Timeline_Notice_color";
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        
        [_topImageView addSubview:_label];
    }
    if (count>0) {
        _label.text = [NSString stringWithFormat:@"更新了%ld条微博",count];
        [UIView animateWithDuration:.6 animations:^{
            _topImageView.transform = CGAffineTransformMakeTranslation(0, 64+5+40);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.6 animations:^{
                [UIView setAnimationDelay:1];
                _topImageView.transform = CGAffineTransformIdentity;
            }];

        }];
        
        
        NSString *path = [[NSBundle mainBundle]
                          pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        AudioServicesPlayAlertSound(soundId);
        
        
        
        
    }
    
    
}



@end
