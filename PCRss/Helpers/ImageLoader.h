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

- (void)loadImage:(NSURL * _Nonnull)imageUrl fromCacheFirst:(BOOL)fromCache completionBlock:(void(^ _Nullable)(UIImage * _Nullable image, BOOL success, NSError * _Nullable error))completion;

@end
