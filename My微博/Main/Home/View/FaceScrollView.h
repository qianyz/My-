//
//  FaceScrollView.h
//  My微博
//
//  Created by mac on 15/11/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceView.h"

@interface FaceScrollView : UIView<UIScrollViewDelegate>
{
    
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    FaceView *_faceView;
    
}

- (void)setFaceViewDelegate:(id<FaceViewDelegate>)delegate;

@end
