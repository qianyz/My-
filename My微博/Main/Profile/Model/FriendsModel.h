//
//  FriendsModel.h
//  My微博
//
//  Created by mac on 15/10/22.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "BaseModel.h"


/*
 返回值字段	    字段类型	     字段说明
 id	            int64	    用户UID
 idstr	        string	   字符串型的用户UID
 screen_name	string	    用户昵称
 profile_image_url	string	用户头像地址（中图），50×50像素
 followers_count	int	粉丝数
 friends_count	 int	关注数
 statuses_count	 int	微博数
 favourites_count	int	收藏数
 
 */
@interface FriendsModel : BaseModel

@property(nonatomic,copy)NSString *screen_name;
@property(nonatomic,copy)NSString *profile_image_url;
@property(nonatomic,retain)NSNumber * followers_count;    //粉丝数




@end