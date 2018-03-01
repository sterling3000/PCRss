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

@property (nonatomic, readonly, nonnull) UIFont  *headlineTitleFont;
@property (nonatomic, readonly, nonnull) UIFont  *headlineDescFont;
@property (nonatomic, readonly, nonnull) UIFont  *tileTitleFont;

- (UICollectionViewFlowLayout * _Nonnull)feedViewLayout;

- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout* _Nonnull)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

- (CGFloat)collectionView:(UICollectionView * _Nonnull)collectionView minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView * _Nonnull)collectionView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

- (CGPoint)headlineTextSpacing;

- (CGPoint)regularTileTextSpacing;

@end
