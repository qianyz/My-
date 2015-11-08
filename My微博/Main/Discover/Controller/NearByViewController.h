//
//  NearByViewController.h
//  My微博
//
//  Created by mac on 15/10/20.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface NearByViewController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
    
}


@end
