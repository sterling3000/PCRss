//
//  FeedViewModel.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "FeedViewModel.h"
#import "FeedCell.h"
#import "Artical.h"

@interface FeedViewModel()

@property (nonatomic, strong) UIFont  *headlineTitleFont;
@property (nonatomic, strong) UIFont  *headlineDescFont;
@property (nonatomic, strong) UIFont  *tileTitleFont;

@end

@implementation FeedViewModel

- (UICollectionViewFlowLayout *)feedViewLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    return layout;
}

- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout* _Nonnull)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    if (indexPath.section == 0) {
        CGFloat w = collectionView.frame.size.width;
        CGFloat h = round(w / [self imageAspectRatio]);
        h += [self headlineTextSpacing].y*5;
        h += [self headlineTitleFont].lineHeight;
        h += [self headlineDescFont].lineHeight*2;
        return CGSizeMake(w, h);
    } else {
        CGFloat x = [self regularTileXSpacing];
        NSInteger numOfTiles = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 2 : 3;
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
        CGFloat w = floor((collectionView.frame.size.width - layout.sectionInset.left*2 - x*(numOfTiles-1))/numOfTiles);
        CGFloat h = round(w / [self imageAspectRatio]);
        h += [self regularTileTextSpacing].y*4;
        h += [self tileTitleFont].lineHeight*2;
        return CGSizeMake(w, h);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return section == 0 ? 0 : 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return section == 0 ? 0 : 5;
}

- (UIFont *)headlineTitleFont {
    if (!_headlineTitleFont) {
        _headlineTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:16];
    }
    return _headlineTitleFont;
}

- (UIFont *)headlineDescFont {
    if (!_headlineDescFont) {
        _headlineDescFont = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
    }
    return _headlineDescFont;
}

- (UIFont *)tileTitleFont {
    if (!_tileTitleFont) {
        _tileTitleFont = [UIFont fontWithName:@"AvenirNext-Regular" size:12];
    }
    return _tileTitleFont;
}

- (CGFloat)regularTileXSpacing {
    return 5.0;
}

- (CGPoint)headlineTextSpacing {
    return CGPointMake(5, 5);
}

- (CGPoint)regularTileTextSpacing {
    return CGPointMake(5, 5);
}

- (CGFloat)imageAspectRatio {
    return 2.6;
}


@end
