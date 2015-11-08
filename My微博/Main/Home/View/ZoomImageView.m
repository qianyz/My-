//
//  ZoomImageView.m
//  My微博
//
//  Created by mac on 15/10/17.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"

@implementation ZoomImageView
{
    NSURLConnection *_connection;
    double _length;
    NSMutableData *_data;
    MBProgressHUD *_hud;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTap];
        [self _createGifIcon];
    }
    return self;
}

-(void)initTap
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomIn)];
    [self addGestureRecognizer:tap];
    self.contentMode = UIViewContentModeScaleAspectFit;

}

-(void)_createGifIcon
{
    _iconView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _iconView.hidden = YES;
    _iconView.image = [UIImage imageNamed:@"timeline_gif.png"];
    
    [self addSubview:_iconView];
    
    
}


-(void)zoomIn
{
    
    if ([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]) {
        [self.delegate imageWillZoomIn:self];
    }

    
    [self createView];
    
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = frame;
    self.hidden = YES;

    [UIView animateWithDuration:.6 animations:^{
        _fullImageView.frame = _scrollView.frame;
    } completion:^(BOOL finished) {
        _scrollView.backgroundColor = [UIColor blackColor];
        
        [self loadDownImage];
    }];
    
    
}

-(void)createView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.window addSubview:_scrollView];
        
        _fullImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.image = self.image;
        [_scrollView addSubview:_fullImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
        [_scrollView addGestureRecognizer:tap];
        
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhoto:)];
        // longPress.minimumPressDuration = 1.5;
        [_scrollView addGestureRecognizer:longPress];

    }
}

-(void)zoomOut
{
    
    
    if ([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        [self.delegate imageWillZoomOut:self];
    }

    
    _scrollView.backgroundColor = [UIColor clearColor];

    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
        
        //如果scroll内容偏移,偏移量也要考虑进去
        _fullImageView.top += _scrollView.contentOffset.y;
        
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _fullImageView = nil;
        self.hidden = nil;
        [_connection cancel];

        
    }];

}

-(void)loadDownImage
{
    if (_fullImageUrlStr.length != 0) {
        _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
        _hud.mode = MBProgressHUDModeDeterminate;
        
        _hud.progress = 0.0;
        
        NSURL *url = [NSURL URLWithString:_fullImageUrlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        
        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

-(void)savePhoto:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存图片" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
        
    }
    

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UIImage *img = _fullImageView.image;
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);


    }
    

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"保存成功");
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSDictionary *headerFields = [httpResponse allHeaderFields];
    NSLog(@"-------------------------------");
    NSLog(@"%@",headerFields);
    
    NSString*lengthStr = [headerFields objectForKey:@"Content-Length"];
    _length = [lengthStr doubleValue];
    _data = [[NSMutableData alloc]init];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    CGFloat progress = _data.length/_length;
    
    _hud.progress = progress;
    NSLog(@"进度  %f",progress);

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"下载完毕");
    
    [_hud hide:YES];
    
    UIImage *image = [UIImage imageWithData:_data];
    _fullImageView.image = image;
    
    CGFloat length = image.size.height/image.size.width * KScreenWidth;
    if (length > KScreenHeight) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _fullImageView.height = length;
            _scrollView.contentSize = CGSizeMake(KScreenWidth, length);
            
        }];
        
    }
    
    
    if (self.isGif) {
        [self gifImageShow];
    }

    
}

-(void)gifImageShow
{
    
    _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
    
}


@end
