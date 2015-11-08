//
//  WeiboAnnotation.h
//  My微博
//
//  Created by mac on 15/10/21.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"
#import <MapKit/MapKit.h>
@interface WeiboAnnotation : NSObject


@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic,strong) WeiboModel *weiboModel;

@end
