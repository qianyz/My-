//
//  MoreTableViewCell.m
//  My微博
//
//  Created by mac on 15/10/9.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "MoreTableViewCell.h"

@implementation MoreTableViewCell


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self _createSubView];
        [self themeChangeAction];
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangeAction) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}


- (void)_createSubView{
    
    _themeimageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(7, 7, 30, 30)];
    
    _themetextLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(40, 11, 200, 20)];
    
    _themedetailLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(KScreenWidth-95-30, 11, 95, 20)];
    
    _themetextLabel.font = [UIFont boldSystemFontOfSize:16];
    _themetextLabel.backgroundColor = [UIColor clearColor];
    _themetextLabel.colorName = @"More_Item_Text_color";
    
    _themedetailLabel.font = [UIFont boldSystemFontOfSize:15];
    _themedetailLabel.backgroundColor = [UIColor clearColor];
    _themedetailLabel.colorName = @"More_Item_Text_color";
    _themedetailLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_themeimageView];
    [self.contentView addSubview:_themetextLabel];
    [self.contentView addSubview:_themedetailLabel];
    
    
}
-(void)themeChangeAction
{
    self.backgroundColor = [[ThemeManager shareInstance] getThemeColor:@"More_Item_color"];
    
    
}
//- (void)layoutSubviews{
//    _themedetailLabel.frame = CGRectMake(KScreenWidth-95-30, 11, 95, 20);
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
