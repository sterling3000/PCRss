//
//  FeedCell.h
//  PCRss
//
//  Created by Zhiye Li on 2/26/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UICollectionViewCell

/// UI Components on the cell
@property (nonatomic, strong, readonly) UIImageView *thumbnail;
@property (nonatomic, strong, readonly) UILabel     *titleLabel;
@property (nonatomic, strong, readonly) UILabel     *descLabel;

/// Layout variables that can be set from the outside.
@property (nonatomic, readwrite) CGFloat            xSpacing;
@property (nonatomic, readwrite) CGFloat            ySpacing;

@end
