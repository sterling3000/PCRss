//
//  PCRssTests.m
//  PCRssTests
//
//  Created by Zhiye Li on 2/24/18.
//  Copyright © 2018 Sterling. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Artical.h"

@interface PCRssTests : XCTestCase

@end

@implementation PCRssTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testArticleValidation {
    Artical *art = [[Artical alloc] initWithTitle:@"title" thumbnail:nil description:nil link:nil publishDate:nil];
    XCTAssertNotNil(art, @"article should not be nil since it has title");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
