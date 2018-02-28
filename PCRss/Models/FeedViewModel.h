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

- (UICollectionViewFlowLayout * _Nonnull)feedViewLayout;

- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout* _Nonnull)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

- (CGFloat)collectionView:(UICollectionView * _Nonnull)collectionView minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat)collectionView:(UICollectionView * _Nonnull)collectionView minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

@end
