//
//  ImageLoader.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader

+ (ImageLoader *)sharedInstance {
    static ImageLoader *instance;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[ImageLoader alloc] init];
    });
    
    return instance;
}

@end
