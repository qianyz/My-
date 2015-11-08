//
//  MyWeiboTableView.m
//  My微博
//
//  Created by mac on 15/10/14.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MyWeiboTableView.h"
#import "MyWeiboCell.h"
#import "WeiboViewFrameLayout.h"
#import "MyWeiboTopCell.h"
@implementation MyWeiboTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        UINib *nib  = [UINib nibWithNibName:@"MyWeiboTopCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"MyWeiboTopCell"];
        UINib *nib1  = [UINib nibWithNibName:@"MyWeiboCell" bundle:nil];
        [self registerNib:nib1 forCellReuseIdentifier:@"MyWeiboCell"];
        self.backgroundColor = [UIColor clearColor];
        
        
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weiboArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MyWeiboTopCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MyWeiboTopCell" forIndexPath:indexPath];

        
        return cell;

    }else{
    MyWeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyWeiboCell" forIndexPath:indexPath];
    WeiboViewFrameLayout *layout = _weiboArray[indexPath.row];

    cell.layout = layout;
    
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        
        return 180;
    }else{
    WeiboViewFrameLayout *layout = _weiboArray[indexPath.row];
    
    return layout.frame.size.height+80;
    }
}


@end
