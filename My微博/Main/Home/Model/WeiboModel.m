//
//  WeiboModel.m
//  XSWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"
@implementation WeiboModel


- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"weiboIdStr":@"idstr"
                             };
    
    return mapAtt;
}

- (void)setAttributes:(NSDictionary*)dataDic{
    
    [super setAttributes:dataDic];
    
    //01 微博来源处理
    //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    // @">.+<"
    if (_source != nil) {
        
        NSString *regex =  @">.+<";
        
        NSArray *array = [_source componentsMatchedByRegex:regex];
        if (array.count != 0) {
            NSString *temp = array[0];
            temp =  [temp substringWithRange:NSMakeRange(1, temp.length-2)];
            
            _source = [NSString stringWithFormat:@"来源:%@",temp];
            
        }
    }
    
    
  
    //用户信息解析
    NSDictionary *userDic  = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        _userModel = [[UserModel alloc] initWithDataDic:userDic];
    }
    
    //被转发的微博

    NSDictionary *reWeiBoDic = [dataDic objectForKey:@"retweeted_status"];
    if (reWeiBoDic != nil) {
         _reWeiboModel = [[WeiboModel alloc] initWithDataDic:reWeiBoDic];
        //02 转发微博的用户的名字处理,拼接字符串
        NSString *name =  _reWeiboModel.userModel.name;
        _reWeiboModel.text = [NSString stringWithFormat:@"@%@:%@",name,_reWeiboModel.text];
        
        
    }
    
    
    //表情处理
    // [兔子]
    // 1.png
    // 这条微博内容[兔子]lsajldjfla
    // 这条微博内容<image url = '1.png'>lsa
    
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceItems = [_text componentsMatchedByRegex:regex];
    
    NSString *configPath = [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfigArray = [NSArray arrayWithContentsOfFile:configPath];
    
    for (NSString *faceName in faceItems) {
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        NSArray *items = [faceConfigArray filteredArrayUsingPredicate:predicate];
        
        if (items.count > 0) {
            NSDictionary *face = items[0];
            NSString *imageName = [face objectForKey:@"png"];
            
            // <image url = '1.png'>

            NSString *replaceStr = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceStr];
            
        }
        
        
        
        
        
    }
    
    
}





@end
