//
//  Artical.h
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artical : NSObject

@property (nonatomic, strong, nonnull) NSString         *title;
@property (nonatomic, strong, nullable) NSURL           *thumbnailUrl;
@property (nonatomic, strong, nullable) NSString        *desc;
@property (nonatomic, strong, nullable) NSURL           *link;

- (id _Nullable)initWithTitle: (NSString * _Nonnull)title
                    thumbnail: (NSURL * _Nullable)url
                  description: (NSString * _Nullable)desc
                         link: (NSURL * _Nullable)link;

@end
