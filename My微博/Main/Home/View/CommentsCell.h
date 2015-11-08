//
//  CommentsCell.h
//  My微博
//
//  Created by mac on 15/10/16.
//  Copyright © 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "WXLabel.h"
@interface CommentsCell : UITableViewCell<WXLabelDelegate>
{
    WXLabel *_commentLabel;
}
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet WXLabel *commentLabel;

@property(nonatomic,retain)CommentModel *commentModel;


+ (float)getCommentHeight:(CommentModel *)commentModel;

@end
