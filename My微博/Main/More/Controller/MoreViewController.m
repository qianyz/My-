//
//  MoreViewController.m
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeListViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
@interface MoreViewController ()
{
    AppDelegate *delegate;
    SinaWeibo *sinaWeibo;
}

@end
static NSString *moreCellId = @"moreCellId";

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];

    [self creatTableView];
    [self getNotification];
    
}



- (void)creatTableView
{
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellId];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)getNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"xxxLogin" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"xxxLogout" object:nil];
}

- (void)reloadData
{
    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [_tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0 ) {
        if (indexPath.row ==0) {
            cell.themeimageView.imageName = @"more_icon_theme.png";
            cell.themetextLabel.text = @"主题选择";
            cell.themedetailLabel.text = [ThemeManager shareInstance].themeName;
        }
        else
        {
            cell.themeimageView.imageName = @"more_icon_account.png";

            cell.themetextLabel.text = @"帐户管理";
        }
    }
    else if (indexPath.section == 1)
    {
        cell.themeimageView.imageName = @"more_icon_feedback.png";
        cell.themetextLabel.text = @"意见反馈";
    }
    else if (indexPath.section == 2)
    {
        if (![sinaWeibo isLoggedIn]) {
            cell.themetextLabel.text =@"登录";
        }else
        {
            cell.themetextLabel.text = @"取消登录";
        }
        cell.themetextLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeListViewController *listVC = [[ThemeListViewController alloc]init];
        [self.navigationController pushViewController:listVC animated:YES];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        if (![sinaWeibo isLoggedIn]) {
            [self logInAction];
        }
        else
        {
            [self logoutAction];

        }
    }
}

- (void)logInAction
{
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    sinaWeibo = delegate.sinaWeibo;
    [sinaWeibo logIn];
}
- (void)logoutAction
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认登出么?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [appDelegate.sinaWeibo logOut];
    }
    
}

@end
