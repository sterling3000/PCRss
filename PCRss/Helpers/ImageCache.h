//
//  ImageCache.h
//  PCRss
//
//  Created by Zhiye Li on 2/27/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCache : NSCache

/// Call this method to retrieve a previous cached image.
- (UIImage * _Nullable)getCachedImageByUrl:(NSURL * _Nonnull)url;

/// Write a image to the cache.
- (void)cacheImage:(UIImage * _Nonnull)image forUrl:(NSURL * _Nonnull)url;

@end
