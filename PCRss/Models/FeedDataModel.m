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

/// Data storage of our feed data
@property (nonatomic, strong) NSMutableArray    *items;

/// Data access queue for the feed item.
@property (nonatomic) dispatch_queue_t          dataQueue;

@end

@implementation FeedDataModel

- (id)init {
    if (self = [super init]) {
        _items = [[NSMutableArray alloc] init];
        
        // handle our data on a separate queue
        _dataQueue = dispatch_queue_create("com.data.feed", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)refreshFeedData {
    [Api.sharedInstance getRssFeedData: ^(BOOL success, NSError *error, NSArray *data){
        if (success) {
            dispatch_sync(_dataQueue, ^{
                [self.items removeAllObjects];
                [self.items addObjectsFromArray:data];
            });

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate feedDataDidLoad:self];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate feedDataFailedToLoad:self error:error];
            });
        }
    }];
}

- (NSArray *)feedItems {
    __block NSArray *items = nil;
    dispatch_sync(_dataQueue, ^{
        items = self.items;
    });
    return items;
}

@end
