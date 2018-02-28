//
//  FeedCell.m
//  PCRss
//
//  Created by Zhiye Li on 2/26/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "FeedCell.h"

@interface FeedCell()

@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *descLabel;

@end

@implementation FeedCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _thumbnail = [[UIImageView alloc] init];
        [self addSubview:_thumbnail];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        [self addSubview:_titleLabel];
     
        [self setupAutolayout];
    }
    return self;
}

- (void)setupAutolayout {
    self.backgroundColor = [UIColor yellowColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Add image
    CGRect imgRect = CGRectMake(0, 0, self.bounds.size.width, round(self.bounds.size.width/2.6));
    _thumbnail.frame = imgRect;
    
    CGFloat xmargin = 10, ymargin = 5;
    CGFloat contentWidth = self.bounds.size.width - 2 * xmargin;
    
    _titleLabel.frame = CGRectMake(xmargin, CGRectGetMaxY(imgRect) + ymargin, contentWidth, _titleLabel.font.pointSize*_titleLabel.numberOfLines);
    if (_descLabel) {
        _descLabel.frame = CGRectMake(xmargin, CGRectGetMaxY(imgRect), contentWidth, _descLabel.font.pointSize*_descLabel.numberOfLines);
    }
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.numberOfLines = 2;
        [self addSubview:_descLabel];
    }
    return _descLabel;
}

@end
