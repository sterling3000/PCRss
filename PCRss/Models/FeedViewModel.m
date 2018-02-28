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
    layout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    return layout;
}

- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout* _Nonnull)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    if (indexPath.section == 0) {
        CGFloat w = collectionView.frame.size.width;
        CGFloat h = round(w / 2.6);
        h += [self headlineTextSpacing].y*2;
        h += [self headlineTitleFontSize];
        h += [self headlineDescFontSize]*2;
        return CGSizeMake(w, h);
    } else {
        CGFloat x = [self regularTileXSpacing];
        NSInteger numOfTiles = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 2 : 3;
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
        CGFloat w = round((collectionView.frame.size.width - layout.sectionInset.left*2 - x*(numOfTiles-1))/numOfTiles);
        CGFloat h = round(w / 2.6);
        h += [self regularTileTextSpacing].y*2;
        h += [self regularTitleFontSize]*2;
        return CGSizeMake(w, h);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return section == 0 ? 0 : 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return section == 0 ? 0 : 5;
}

- (CGFloat)headlineTitleFontSize {
    return 20;
}

- (CGFloat)headlineDescFontSize {
    return 16;
}

- (CGFloat)regularTitleFontSize {
    return 16;
}

- (CGPoint)headlineTextSpacing {
    return CGPointMake(10, 5);
}

- (CGPoint)regularTileTextSpacing {
    return CGPointMake(10, 5);
}

- (CGFloat)regularTileXSpacing {
    return 10;
}

@end
