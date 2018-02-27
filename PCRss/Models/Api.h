//
//  Api.h
//  PCRss
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Api : NSObject

+ (Api * _Nullable)sharedInstance;

- (void)getRssFeedData: (void (^ _Nullable)(BOOL success, NSError * _Nullable error, NSArray * _Nullable feeds))completion;

@end
