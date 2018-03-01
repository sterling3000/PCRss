//
//  FeedViewModel.h
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FeedViewModel : NSObject

/// The fonts that we will be guiding the tiles to render text with.
@property (nonatomic, readonly, nonnull) UIFont  *headlineTitleFont;
@property (nonatomic, readonly, nonnull) UIFont  *headlineDescFont;
@property (nonatomic, readonly, nonnull) UIFont  *tileTitleFont;

/// Section insets of the collection view
- (UIEdgeInsets)collectionViewLayoutSectionInsets;

/// Call the following 3 methods to re-route the collection view delegate calls.
- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout* _Nonnull)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

- (CGFloat)collectionView:(UICollectionView * _Nonnull)collectionView minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView * _Nonnull)collectionView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

/// The text spacing in x axis and y axis on the headline tile.
- (CGPoint)headlineTextSpacing;

// x spacing and y spacing for the texts on each regular tile (non-headline tile).
- (CGPoint)regularTileTextSpacing;

@end
