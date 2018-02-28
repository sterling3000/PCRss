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

- (UIImage * _Nullable)getCachedImageByUrl:(NSURL * _Nonnull)url;

- (void)cacheImage:(UIImage * _Nonnull)image forUrl:(NSURL * _Nonnull)url;

@end
