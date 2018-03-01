//
//  ImageLoader.h
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageLoader : NSObject

+ (id _Nonnull)sharedInstance;

/// Call this method to retrieve the specific image by its URL, either from the cache if exists, or from the web.
- (void)loadImage:(NSURL * _Nonnull)imageUrl fromCacheFirst:(BOOL)fromCache completionBlock:(void(^ _Nullable)(UIImage * _Nullable image, BOOL success, NSError * _Nullable error))completion;

@end
