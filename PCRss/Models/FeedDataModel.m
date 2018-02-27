//
//  FeedDataModel.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "FeedDataModel.h"
#import "Api.h"

@interface FeedDataModel()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation FeedDataModel

- (void)refreshFeedData {
    [Api.sharedInstance getRssFeedData: ^(BOOL success, NSError *error, NSArray *data){
        if (success) {
            [self.items removeAllObjects];
            [self.items addObjectsFromArray:data];
            [self.delegate feedDataDidLoad:self];
        } else {
            [self.delegate feedDataFailedToLoad:self error:error];
        }
    }];
}

- (NSArray *)feedItems {
    return self.items;
}

@end
