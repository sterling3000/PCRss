//
//  FeedCell.h
//  PCRss
//
//  Created by Zhiye Li on 2/26/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UIImageView *thumbnail;
@property (nonatomic, strong, readonly) UILabel     *titleLabel;
@property (nonatomic, strong, readonly) UILabel     *descLabel;

@end
