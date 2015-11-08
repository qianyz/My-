//
//  SendViewController.h
//  My微博
//
//  Created by mac on 15/10/19.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>
#import "FaceScrollView.h"

@interface SendViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UITableViewDelegate,UIImagePickerControllerDelegate,ZoomImageViewDelegate,CLLocationManagerDelegate,FaceViewDelegate>
{
    UITextView *_textView;
    UIView *_editorBar;
    ZoomImageView *_zoomImageView;
    // 位置管理器
    CLLocationManager *_locationManager;
    UILabel *_locationLabel;
    
    //表情面板
    FaceScrollView *_faceViewPanel;

}
@end
