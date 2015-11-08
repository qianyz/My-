//
//  Common.h
//  My微博
//
//  Created by mac on 15/10/8.
//  Copyright © 2015年 mac. All rights reserved.
//

#ifndef Common_h
#define Common_h


#define kVersion   [[UIDevice currentDevice].systemVersion doubleValue]

#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define kAppKey             @"1148028607"
#define kAppSecret          @"8df84684bdc7b02717a222bb546d0a54"
#define kAppRedirectURI     @"http://www.sina.com"

#define unread_count @"remind/unread_count.json"  //未读消息
#define home_timeline @"statuses/home_timeline.json"  //微博列表
#define comments  @"comments/show.json"   //评论列表
#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)
#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈
#define nearby_timeline  @"place/nearby_timeline.json" //附近动态

#define FontSize_Weibo(isDetail)     isDetail?16:15
#define FontSize_ReWeibo(isDetail) isDetail?15:14


#endif /* Common_h */
