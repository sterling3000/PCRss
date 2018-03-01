//
//  Api.m
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import "Api.h"
#import "Artical.h"
#import "GDataXMLNode.h"

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
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data error:&parseError];
            
            if (parseError) {
                if (completion) {
                    completion(NO, error, nil);
                }
            } else {
                NSMutableArray *articals = [[NSMutableArray alloc] init];
                NSError *itemsError;
                NSArray *items = [doc nodesForXPath:@"//channel/item" error:&itemsError];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"E, d MMM yyyy HH:mm:ss Z"];
                
                for (GDataXMLElement *item in items) {
                    
                    NSString *title, *link, *dateString, *desc = nil;
                    if ([item elementsForName:@"title"].count)
                        title = [[[item elementsForName:@"title"] objectAtIndex:0] stringValue];
                    if ([item elementsForName:@"link"])
                        link = [[[item elementsForName:@"link"] objectAtIndex:0] stringValue];
                    NSURL *linkUrl = nil;
                    if (link)
                        linkUrl = [NSURL URLWithString:link];
                    if ([item elementsForName:@"pubDate"].count)
                        dateString = [[[item elementsForName:@"pubDate"] objectAtIndex:0] stringValue];
                    NSDate *date = [formatter dateFromString:dateString];
                    NSURL *thumbUrl = nil;
                    NSString *thumb = nil;
                    NSArray *thumbElements = [item elementsForName:@"media:content"];
                    if (thumbElements.count) {
                        thumb = [[thumbElements[0] attributeForName:@"url"] stringValue];
                    }
                    if (thumb)
                        thumbUrl = [NSURL URLWithString:thumb];
                    if ([item elementsForName:@"description"].count)
                        desc = [[[item elementsForName:@"description"] objectAtIndex:0] stringValue];
                    GDataXMLDocument *descDoc = [[GDataXMLDocument alloc] initWithXMLString:desc error:&itemsError];
                    NSString *descString = [[descDoc firstNodeForXPath:@"/p" error:&itemsError] stringValue];
                    
                    Artical *art = [[Artical alloc] initWithTitle:title thumbnail:thumbUrl description:descString link:linkUrl publishDate:date];
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
