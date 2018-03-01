//
//  FeedDataModel.h
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedDataModel;

@protocol FeedDataModelDelegate <NSObject>

- (void)feedDataDidLoad: (FeedDataModel * _Nonnull)model;
- (void)feedDataFailedToLoad: (FeedDataModel * _Nonnull)model error: (NSError * _Nullable)error;

@end

@interface FeedDataModel : NSObject

@property (nonatomic, weak, nullable) id<FeedDataModelDelegate>     delegate;
@property (nonatomic, nonnull, readonly) NSArray                *feedItems;

/// Reload content from the RSS feed. The refresh button on the main screen triggers this operation.
- (void)refreshFeedData;

@end


