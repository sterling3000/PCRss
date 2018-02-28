//
//  ImageCache.m
//  PCRss
//
//  Created by Zhiye Li on 2/27/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "ImageCache.h"

@interface ImageCache()

@property (nonatomic) dispatch_queue_t      cacheQueue;

@end

@implementation ImageCache

- (id)init {
    if (self = [super init]) {
        self.countLimit = 20;
        self.totalCostLimit = 1024*1024*1024;
        _cacheQueue = dispatch_queue_create("com.cache.image", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (UIImage * _Nullable)getCachedImageByUrl:(NSURL * _Nonnull)url {
    __block UIImage *img = nil;
    dispatch_sync(_cacheQueue, ^{
        img = [self objectForKey:url.absoluteString];
    });
    return img;
}

- (void)cacheImage:(UIImage * _Nonnull)image forUrl:(NSURL * _Nonnull)url {
    dispatch_async(_cacheQueue, ^{
        [self setObject:image forKey:url.absoluteString];
    });
}

@end
