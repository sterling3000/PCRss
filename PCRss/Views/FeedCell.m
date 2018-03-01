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
        
        self.layer.borderColor = [UIColor colorWithWhite:0 alpha:.2].CGColor;
        self.layer.borderWidth = 0.5;
        
        // Initial spacing default value
        _xSpacing = 5.;
        _ySpacing = 5.;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Add image
    CGRect imgRect = CGRectMake(0, 0, self.bounds.size.width, round(self.bounds.size.width/2.6));
    _thumbnail.frame = imgRect;
    
    CGFloat contentWidth = self.bounds.size.width - 2 * _xSpacing;
    
    _titleLabel.frame = CGRectMake(_xSpacing, CGRectGetMaxY(imgRect)+_ySpacing, contentWidth, _titleLabel.font.pointSize*_titleLabel.numberOfLines+_ySpacing*2);
    if (_descLabel) {
        _descLabel.frame = CGRectMake(_xSpacing, CGRectGetMaxY(_titleLabel.frame), contentWidth, _descLabel.font.pointSize*_descLabel.numberOfLines+_ySpacing*2);
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
