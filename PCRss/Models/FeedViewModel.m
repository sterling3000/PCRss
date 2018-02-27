//
//  FeedViewModel.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "FeedViewModel.h"

@implementation FeedViewModel

- (UICollectionViewFlowLayout *)feedViewLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return layout;
}

- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    return CGSizeMake(100, 100);
}

@end
