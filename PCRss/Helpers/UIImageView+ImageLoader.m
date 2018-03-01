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
    
    UIActivityIndicatorView *spinner = nil;
    if (!self.image) {
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.hidesWhenStopped = YES;
        spinner.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [self addSubview:spinner];
        [spinner startAnimating];
    }
    
    // Start loading the image.
    [[ImageLoader sharedInstance] loadImage:url fromCacheFirst:YES completionBlock:^(UIImage *image, BOOL success, NSError *error) {
        if (spinner) {
            [spinner stopAnimating];
            [spinner removeFromSuperview];
        }
        if (success) {
            // upon success, we want to do a little fading animation so the tiles don't kick in abruptly.
            self.alpha = 0;
            self.image = image;
            [UIView animateWithDuration:.25 animations:^{
                self.alpha = 1;
            }];
        }
    }];
}

@end
