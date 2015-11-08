//
//  MyWeiboTopCell.m
//  My微博
//
//  Created by mac on 15/10/15.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MyWeiboTopCell.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "HomeViewController.h"
#import "FriendsViewController.h"
#import "FollowersViewController.h"
#import "UIView+ViewController.h"

@implementation MyWeiboTopCell

-(void)awakeFromNib {
    [self _createSubView];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = delegate.sinaWeibo;
    [sinaWeibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
    
    
   
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneAction)];
    [_view1 addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoAction)];
    [_view2 addGestureRecognizer:tap2];
    
    
}

-(void)oneAction
{
    NSLog(@"============");
    FriendsViewController *VC = [[FriendsViewController alloc]init];
    VC.title = @"关注列表";
    VC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:VC animated:YES];
    
}
-(void)twoAction
{
    NSLog(@"-------------");
    FollowersViewController *VC = [[FollowersViewController alloc]init];
    VC.title = @"粉丝列表";
    VC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:VC animated:YES];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)_createSubView
{
    
    _numlabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 74, 20)];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 74, 15)];
    label1.text = @"关注";
    [_view1 addSubview:_numlabel1];
    [_view1 addSubview:label1];
    
    _numlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 74, 20)];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 74, 15)];
    label2.text = @"粉丝";
    [_view2 addSubview:_numlabel2];
    [_view2 addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 74, 15)];
    label3.text = @"资料";
    [_view3 addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, 74, 15)];
    label4.text = @"更多";
    [_view4 addSubview:label4];
    
    
    
}

-(void)setLayout:(WeiboViewFrameLayout *)layout
{
    if (_layout != layout) {
        _layout = layout;

    }
}



- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"result = %@",result);

    [_userImage sd_setImageWithURL:[NSURL URLWithString:[result objectForKey:@"profile_image_url"]]];
    _userName.text = [result objectForKey:@"screen_name"];
    _otherLabel.text = [result objectForKey:@"location"];
    _jianjieLabel.text = [result objectForKey:@"description"];
    _numlabel1.text = [NSString stringWithFormat:@"%@",[result objectForKey:@"friends_count"]];
    _numlabel2.text = [NSString stringWithFormat:@"%@",[result objectForKey:@"followers_count"]];

    
}


@end
