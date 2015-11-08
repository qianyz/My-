//
//  WeiboTableView.m
//  My微博
//
//  Created by mac on 15/10/12.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboViewFrameLayout.h"
#import "DetailViewController.h"
#import "UIView+ViewController.h"
@implementation WeiboTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initTable];
        
    }
    return self;
}

- (void)awakeFromNib{
    
    [self _initTable];
    
}

- (void)_initTable{
    
    self.delegate = self;
    self.dataSource = self;
    UINib *nib  = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:@"WeiboCell"];
    self.backgroundColor = [UIColor clearColor];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weiboArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell" forIndexPath:indexPath];
    WeiboViewFrameLayout *layout = _weiboArray[indexPath.row];
    
    
    
    cell.layout = layout;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiboViewFrameLayout *layout = _weiboArray[indexPath.row];
    
    return layout.frame.size.height+80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    
    WeiboViewFrameLayout *layout = _weiboArray[indexPath.row];
//    WeiboModel *model = _weiboArray[indexPath.row];
    
    detailVC.model = layout.model;
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
}


@end
