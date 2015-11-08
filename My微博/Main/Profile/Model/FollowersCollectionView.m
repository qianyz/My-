//
//  FollowersCollectionView.m
//  My微博
//
//  Created by mac on 15/10/23.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "FollowersCollectionView.h"
#import "FriendsCell.h"

@interface FollowersCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
}
@end

@implementation FollowersCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        UINib *nib = [UINib nibWithNibName:@"FriendsCell" bundle:nil];
        [self registerNib:nib forCellWithReuseIdentifier:@"cell"];
        
    }
    return self;
}



#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _followersArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = _followersArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
