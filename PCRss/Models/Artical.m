//
//  Artical.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "Artical.h"

@implementation Artical

- (id)initWithTitle: (NSString * _Nonnull)title
          thumbnail: (NSURL * _Nullable)url
        description: (NSString * _Nullable)desc
               link: (NSURL * _Nullable)link {
    
    if (self = [super init]) {
        _title = title;
        _link = link;
        _desc = desc;
        _thumbnailUrl = url;
    }
    
    return [self validate] ? self : nil;
}

- (BOOL)validate {
    return _title != nil;
}

@end
