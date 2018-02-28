//
//  ImageLoader.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "ImageLoader.h"
#import "ImageCache.h"

@interface ImageLoader()

@property (nonatomic, strong) ImageCache       *imageCache;

@end

@implementation ImageLoader

+ (ImageLoader *)sharedInstance {
    static ImageLoader *instance;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[ImageLoader alloc] init];
        instance.imageCache = [[ImageCache alloc] init];
    });
    
    return instance;
}

- (void)loadImage:(NSURL *)imageUrl fromCacheFirst:(BOOL)fromCache completionBlock:(void(^)(UIImage *image, BOOL success, NSError *error))completion {
    // Look in the cache first
    if (fromCache) {
        UIImage *img = [_imageCache getCachedImageByUrl:imageUrl];
        if (img) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(img, YES, nil);
                }
            });
            return;
        }
    }

    // Download it
    NSURLSessionTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:imageUrl completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        if ([(NSHTTPURLResponse *)response statusCode] < 400 && !error) {
            UIImage *img = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
            if (img) {
                // Save to cache
                [_imageCache cacheImage:img forUrl:imageUrl];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(img, YES, nil);
                    }
                });
            } else {
                if (completion) {
                    completion(nil, NO, nil);
                }
            }
        }
    }];
    [task resume];
    
}

@end
