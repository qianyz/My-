//
//  SendViewController.m
//  My微博
//
//  Created by mac on 15/10/19.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "SendViewController.h"
#import "ThemeButton.h"
#import "DataService.h"
@interface SendViewController ()
{
    UIImage *_sendImage;
}

@end

@implementation SendViewController

- (void)dealloc{
    NSLog(@"SendViewController 被销毁了了");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return  self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout =  UIRectEdgeNone;

    [self initTopBtn];
    [self createViews];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated ];

    [_textView becomeFirstResponder];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //导航栏不透明，当导航栏不透明的时候 ，子视图的y的0位置在导航栏下面
    // self.navigationController.navigationBar.translucent = NO;
    //_textView.frame = CGRectMake(0, 0, kScreenWidth, 120);
    
    
    //弹出键盘
    [_textView becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTopBtn
{
    ThemeButton *btn1 = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn1.normalImageName = @"button_icon_close.png";
    [btn1 addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *b1 = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = b1;
    
    ThemeButton *btn2 = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    btn2.normalImageName = @"button_icon_ok.png";
    [btn2 addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *b2 = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItem = b2;

}

-(void)closeAction
{
    [self resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendAction
{
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"微博内容为空";
    }
    else if(text.length > 140) {
        error = @"微博内容大于140字符";
    }
    //弹出提示错误信息
    if (error != nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
//    [DataService sendWeibo:text image:_sendImage block:^(id result) {
//        NSLog(@"%@",result);
//    }];
    //发送
    AFHTTPRequestOperation *operation =  [DataService sendWeibo:text image:_sendImage block:^(id result) {
        NSLog(@"发送反馈 %@",result);
        [self showStatusTip:@"发送完毕" show:NO operation:nil];
    }];
    
    
    [self showStatusTip:@"正在发送" show:YES operation:operation];
    
    [self closeAction];
    

    [self dismissViewControllerAnimated:YES completion:nil];
    

}

-(void)createViews
{
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 100)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.editable = YES;
    _textView.backgroundColor = [UIColor lightGrayColor];
    
    _textView.layer.cornerRadius = 10;
    _textView.layer.borderWidth = 2;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_textView];
    
    
    _editorBar = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 55)];
    _editorBar.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_editorBar];
    
    NSArray *imgs = @[
                      @"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_5.png",
                      @"compose_toolbar_6.png"
                      ];
    for (int i = 0; i<5; i++) {
        ThemeButton *btn = [[ThemeButton alloc]initWithFrame:CGRectMake((KScreenWidth/5)*i, 20, 40, 33)];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+10;
        btn.normalImageName = imgs[i];
        [_editorBar addSubview:btn];
        
        
    }
    
    //3 创建label 显示位置信息
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    _locationLabel.hidden = YES;
    _locationLabel.font = [UIFont systemFontOfSize:14];
    _locationLabel.backgroundColor = [UIColor grayColor];
    [_editorBar addSubview:_locationLabel];
    
}

-(void)btnAction:(UIButton *)button
{
    NSLog(@"%li",button.tag);
    
    
    if (button.tag == 10) {
        //选择照片
        [self _selectPhoto];
    }else if (button.tag == 13){
        //显示位置
        [self _location];

    }else if(button.tag == 14) {  //显示、隐藏表情
        BOOL isFirstResponder = _textView.isFirstResponder;
        
        //输入框是否是第一响应者，如果是，说明键盘已经显示
        if (isFirstResponder) {
            //隐藏键盘
            [_textView resignFirstResponder];
            //显示表情
            [self _showFaceView];
            //隐藏键盘
            
        } else {
            //隐藏表情
            [self _hideFaceView];
            
            //显示键盘
            [_textView becomeFirstResponder];
        }

        
    }
}

- (void)keyBoardWillShow:(NSNotification *)notification{
    
    NSLog(@"%@",notification);
    //1 取出键盘frame,这个frame 相对于window的
    NSValue *bounsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect frame = [bounsValue CGRectValue];
    //2 键盘高度
    CGFloat height = frame.size.height;
    //3 调整视图的高度
    _editorBar.bottom = KScreenHeight - height- 64;
    
}
#pragma mark - 选择照片

//选图片
-(void)_selectPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [actionSheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        
        
        if (isCamera) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"摄像头无法使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            
            return;

        }
    }else if (buttonIndex == 1){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else{
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

//照片选择代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //选照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (_zoomImageView == nil) {
        _zoomImageView = [[ZoomImageView alloc]init];
        _zoomImageView.frame = CGRectMake(10, _textView.bottom+10, 80, 80);
        [self.view addSubview:_zoomImageView];
        
        _zoomImageView.delegate = self;
    }
    
    
    _zoomImageView.image = image;
    _sendImage = image;
    
}

#pragma mark - zoomImageViewDelegate

- (void)imageWillZoomOut:(ZoomImageView *)imageView{
    
    [_textView becomeFirstResponder];
    
}

- (void)imageWillZoomIn:(ZoomImageView *)imageView{
    
    [_textView resignFirstResponder];
    
}

#pragma mark - 地理位置

-(void)_location
{
    if (_locationManager ==nil) {
        _locationManager = [[CLLocationManager alloc]init];
        
        if (kVersion>8.0) {
            [_locationManager requestWhenInUseAuthorization];
            
        }
    }
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    _locationManager.delegate = self;
    //开始定位
    [_locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止定位
    [manager stopUpdatingLocation];
    //取得地理位置信息
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;//获取经纬度
    NSLog(@"经度 ：%lf,纬度： %lf",coordinate.longitude,coordinate.latitude);
    
    //地理位置反编码
    //一 新浪位置反编码 接口说明  http://open.weibo.com/wiki/2/location/geo/geo_to_address
//    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:coordinateStr forKey:@"coordinate"];
//    
//    __weak SendViewController *weakSelf = self;
//    [DataService requestAFUrl:geo_to_address httpMethod:@"GET" params:params data:nil block:^(id result) {
//        
//        NSArray *geos = [result objectForKey:@"geos"];
//        if (geos.count > 0) {
//            NSDictionary *geoDic = [geos lastObject];
//            NSString *addr = [geoDic objectForKey:@"address"];
//            NSLog(@"地址 %@",addr);
//            __strong SendViewController *strongSelf = weakSelf;
//
//            strongSelf->_locationLabel.hidden = NO;
//            
//            strongSelf->_locationLabel.text = addr;
//            
//        }
//        
//        
//        
//        
//    }];
    
    //二 iOS内置 反编码
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"%@",place.name);

        _locationLabel.hidden = NO;
        _locationLabel.text = place.name;
    }];
    
    
    
}

#pragma mark - 表情处理

- (void)_showFaceView{
    
    //创建表情面板
    if (_faceViewPanel == nil) {
        
        
        _faceViewPanel = [[FaceScrollView alloc] init];
        [_faceViewPanel setFaceViewDelegate:self];
        //放到底部
        _faceViewPanel.top  = KScreenHeight-64;
        [self.view addSubview:_faceViewPanel];
    }
    
    //显示表情
    [UIView animateWithDuration:0.3 animations:^{
        
        _faceViewPanel.bottom = KScreenHeight-64;
        //重新布局工具栏、输入框
        _editorBar.bottom = _faceViewPanel.top;
        
    }];
}

//隐藏表情
- (void)_hideFaceView {
    
    //隐藏表情
    [UIView animateWithDuration:0.3 animations:^{
        _faceViewPanel.top = KScreenHeight-64;
        
    }];
    
}
- (void)faceDidSelect:(NSString *)text{
    NSLog(@"选中了%@",text);
    
    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,text];
}


@end
