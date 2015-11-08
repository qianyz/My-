//
//  CommentModel.m
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "CommentModel.h"
#import "Utils.h"

@implementation CommentModel
-(void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    _user = [[UserModel alloc]initWithDataDic:userDic];
    
    NSDictionary *status = [dataDic objectForKey:@"status"];
    _weibo = [[WeiboModel alloc] initWithDataDic:status];
    
    NSDictionary *commentDic = [dataDic objectForKey:@"reply_comment"];
    if (commentDic != nil) {
        _sourceComment = [[CommentModel alloc] initWithDataDic:commentDic];
//        self.sourceComment = sourceComment;
    }
    
    self.text = [Utils parseTextImage:_text];
    

    
    
    

    
}
@end
