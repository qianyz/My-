//
//  LeftViewController.m
//  My微博
//
//  Created by mac on 15/10/10.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "LeftViewController.h"
#import "ThemeLabel.h"
#import "ThemeManager.h"
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSDictionary *_cellTitle;
    NSArray *_sectionTitle;
    NSArray *_rowTitle;
}
@end

static NSString *identifier = @"leftCellId";

@implementation LeftViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
     ];
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    
    return self;
}

-(void)themeDidChange:(NSNotification *)notification
{
    [self _loadImage];
}

-(void)_loadImage
{
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self _createView];
    [self _loadImage];
}

-(void)_createView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, 165, KScreenHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = nil;
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];

    
}

-(void)loadData
{
    
    _sectionTitle = @[@"界面切换效果",@"图片浏览模式"];
    _rowTitle = @[@[@"无",
                    @"偏移",
                    @"偏移&缩放",
                    @"旋转",
                    @"视差"],
                  @[@"小图",
                    @"大图"]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rowTitle[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.selectionStyle =UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = _rowTitle[indexPath.section][indexPath.row];
    
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:CGRectMake(0,0, 150, 50)];
    label.colorName = @"More_Item_Text_color";
    label.font = [UIFont boldSystemFontOfSize:16];
    label.backgroundColor = [UIColor clearColor];
    label.text = _sectionTitle[section];
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
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

@end
