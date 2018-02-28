//
//  UIImageView+ImageLoader.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "UIImageView+ImageLoader.h"
#import "ImageLoader.h"

@implementation UIImageView (ImageLoader)

- (void)setImageWithUrl: (NSURL * _Nonnull)url {
    [[ImageLoader sharedInstance] loadImage:url fromCacheFirst:YES completionBlock:^(UIImage *image, BOOL success, NSError *error) {
        if (success) {
            self.alpha = 0;
            self.image = image;
            [UIView animateWithDuration:.25 animations:^{
                self.alpha = 1;
            }];
        }
    }];
}

@end
