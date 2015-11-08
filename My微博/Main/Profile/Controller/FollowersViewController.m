//
//  FollowersViewController.m
//  My微博
//
//  Created by mac on 15/10/22.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "FollowersViewController.h"
#import "FollowersCollectionView.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "FriendsModel.h"
@interface FollowersViewController ()<SinaWeiboRequestDelegate>
{
    FollowersCollectionView *followersCV;
    
}
@end

@implementation FollowersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createSubView];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    [sinaWeibo requestWithURL:@"friendships/followers.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}

-(void)_createSubView
{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 150);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10,10, 10);
    
    followersCV = [[FollowersCollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
    followersCV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:followersCV];
    [self showHUD:@"正在加载..."];

}



- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"result = %@",result);
    NSArray *dicArray = [result objectForKey:@"users"];
    NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:dicArray.count];
    
    for (NSDictionary *dataDic in dicArray) {
        FriendsModel*model = [[FriendsModel alloc] initWithDataDic:dataDic];
        
        [mArray addObject:model];
    }
    [self completeHUD:@"加载完成"];
    followersCV.followersArray = mArray;
    [followersCV reloadData];
    
}

@end
