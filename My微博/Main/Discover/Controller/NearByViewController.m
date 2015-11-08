//
//  NearByViewController.m
//  My微博
//
//  Created by mac on 15/10/20.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "NearByViewController.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "DataService.h"
#import "WeiboModel.h"
#import "DetailViewController.h"
@interface NearByViewController ()

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createViews];
    [self _location];
}

-(void)_createViews
{
    _mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    //显示用户位置
    _mapView.showsUserLocation = YES;
    //地图显示类型 ： 标准、卫星 、混合
    _mapView.mapType = MKMapTypeSatellite;
    //用户跟踪模式
//    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
}

//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    CLLocation *location = userLocation.location;
//    CLLocationCoordinate2D coordinate = location.coordinate;
//    NSLog(@"纬度  %lf,精度 %lf",coordinate.latitude,coordinate.longitude);
//
//    
//}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"选中");
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    
    WeiboAnnotation *weiboAnnotation = (WeiboAnnotation *)view.annotation;
    WeiboModel *weiboModel = weiboAnnotation.weiboModel;
    
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.model = weiboModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    if ([annotation isKindOfClass:[WeiboAnnotation class]]) {
        WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
        if (annotationView == nil) {
            annotationView = [[WeiboAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"view"];
            
        }
        annotationView.annotation = annotation;
        
        return annotationView;
        
        
        
    }

    return nil;
    
}

-(void)_location
{
    _locationManager = [[CLLocationManager alloc]init];
    if (kVersion >8.0) {
        [_locationManager requestWhenInUseAuthorization];
        
    }
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //1 停止定位
    [_locationManager stopUpdatingLocation];
    //2 请求数据
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [self _loadNearByData:lon lat:lat];

    
    //3 设置地图显示区域
    //>>01 设置 center
    CLLocationCoordinate2D center = coordinate;
    
    //>>02 设置span ,数值越小,精度越高，范围越小
    MKCoordinateSpan span = {.2,.2};
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];
    
}

- (void)_loadNearByData:(NSString *)lon lat:(NSString *)lat
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    
    [DataService requestAFUrl:nearby_timeline httpMethod:@"GET" params:params data:nil block:^(id result) {
        
        NSArray *statuses = [result objectForKey:@"statuses"];
        NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:statuses.count];
        
        for (NSDictionary *dic in statuses) {
            WeiboModel *model = [[WeiboModel alloc]initWithDataDic:dic];
            
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc]init];
            annotation.weiboModel = model;
            [mArray addObject:annotation];
            
        }
        
        [_mapView addAnnotations:mArray];
        
    }];
    
}
@end
