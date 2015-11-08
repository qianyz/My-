//
//  DetailTableView.m
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "DetailTableView.h"
#import "CommentsCell.h"
#import "WeiboViewFrameLayout.h"
@implementation DetailTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self createTable];
        self.delegate = self;
        self.dataSource = self;
        
        UINib *nib  = [UINib nibWithNibName:@"CommentsCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"CommentCell"];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)createTable
{
    _tablrHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 0)];
    _tablrHeaderView.backgroundColor = [UIColor clearColor];
    
    _userView = [[[NSBundle mainBundle]loadNibNamed:@"UserView" owner:self options:nil]lastObject];
    _userView.backgroundColor = [UIColor clearColor];
    _userView.width = KScreenWidth-100;
//    _userView.height =10;
    [_tablrHeaderView addSubview:_userView];
    
    _weiboView = [[WeiboView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
    _weiboView.contentMode = UIViewContentModeScaleAspectFit;
    [_tablrHeaderView addSubview:_weiboView];
}

-(void)setModel:(WeiboModel *)model
{
    if (_model != model) {
        _model = model;
        
        
        WeiboViewFrameLayout *layout = [[WeiboViewFrameLayout alloc]init];
        layout.isDetail = YES;

        layout.model = model;
        
        _weiboView.layout = layout;
        _weiboView.frame = layout.frame;
        _weiboView.top = _userView.bottom+5;
        
        _userView.model = model;
        
        _tablrHeaderView.height = _weiboView.bottom;
        
        
        self.tableHeaderView = _tablrHeaderView;
        
        
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置组的头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentModel *model = self.commentsArray[indexPath.row];
    //计算单元格的高度
    CGFloat height = [CommentsCell getCommentHeight:model];
    
    return height;
    
//    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //1.创建组视图
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    
    //2.评论Label
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    countLabel.textColor = [UIColor blackColor];
    
    
    //3.评论数量
    NSNumber *total = [self.commentDic objectForKey:@"total_number"];
    int value = [total intValue];
    countLabel.text = [NSString stringWithFormat:@"评论:%d",value];
    [sectionHeaderView addSubview:countLabel];
    
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    
    return sectionHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    
    cell.commentModel = self.commentsArray[indexPath.row];
    
    return cell;
    
    
    
    
}




@end
