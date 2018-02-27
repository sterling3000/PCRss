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

- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;

@end
