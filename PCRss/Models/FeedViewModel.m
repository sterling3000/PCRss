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
    if (indexPath.section == 0) {
        
    } else {
        
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return section == 0 ? 0 : 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return section == 0 ? 0 : 10;
}

- (CGFloat)handlineTitleFontSize {
    return 20;
}

- (CGFloat)headlineDescFontSize {
    return 16;
}

- (CGFloat)regularTitleFontSize {
    return 16;
}

- (CGFloat)regularDescFontSize {
    return 14;
}

- (CGPoint)headlineTextSpacing {
    return CGPointMake(10, 5);
}

- (CGPoint)regularTileTextSpacing {
    return CGPointMake(10, 5);
}

@end
