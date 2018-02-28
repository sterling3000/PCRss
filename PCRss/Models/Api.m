//
//  Api.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "Api.h"
#import "HTMLParser.h"
#import "Artical.h"

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
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://www.personalcapital.com/blog/feed/?cat=3,891,890,68,284"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([(NSHTTPURLResponse *)response statusCode] < 400 && !error) {
            
            NSError *parseError;
            HTMLParser *parser = [[HTMLParser alloc] initWithData:data error:&parseError];
            if (parseError) {
                if (completion) {
                    completion(NO, error, nil);
                }
            } else {
                NSMutableArray *articals = [[NSMutableArray alloc] init];
                HTMLNode *channel = [[parser body] findChildTag:@"channel"];
                NSArray *items = [channel findChildTags:@"item"];

                for (HTMLNode *item in items) {
                    NSString *title = [[item findChildTag:@"title"] contents];
                    NSString *link = [[item findChildTag:@"comments"] contents];
                    NSURL *linkUrl = nil;
                    if (link)
                        linkUrl = [NSURL URLWithString:link];
                    NSString *desc = [[item findChildTag:@"description"] contents];
                    NSString *thumb = [[item findChildTag:@"content"] getAttributeNamed:@"url"];
                    NSURL *thumbUrl = nil;
                    if (thumb)
                        thumbUrl = [NSURL URLWithString:thumb];
                    
                    Artical *art = [[Artical alloc] initWithTitle:title thumbnail:thumbUrl description:desc link:linkUrl];
                    if (art)
                        [articals addObject:art];
                }
                if (completion) {
                    completion(YES, nil, articals);
                }
            }
            
        } else {
            if (completion) {
                completion(NO, error, nil);
            }
        }
    }];
    [task resume];
}


@end
