//
//  Api.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "Api.h"

@implementation Api

+ (Api *)sharedInstance {
    static Api *instance;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[Api alloc] init];
    });
    
    return instance;
}

- (void)getRssFeedData: (void (^)(BOOL success, NSError *error, NSArray *feeds))completion {
    
}


@end
