//
//  FaceView.h
//  My微博
//
//  Created by mac on 15/11/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaceViewDelegate <NSObject>

- (void)faceDidSelect:(NSString *)text;

@end

@interface FaceView : UIView
{
    NSMutableArray *_items;  //二维数组
    //放大镜视图
    UIImageView *_magnifierView;
    
    //选中的表情名
    NSString *_selectedFaceName;
}

@property(nonatomic,readonly)NSInteger pageNumber;
@property (nonatomic,weak) id<FaceViewDelegate> delegate;

@end
