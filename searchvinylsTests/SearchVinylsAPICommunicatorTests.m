//
//  SearchVinylsAPICommunicatorTests.m
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "InspectableSearchVinylsAPICommunicator.h"

@interface SearchVinylsAPICommunicatorTests : XCTestCase {
    InspectableSearchVinylsAPICommunicator* communicator;
}
@end

@implementation SearchVinylsAPICommunicatorTests

- (void)setUp {
    [super setUp];
    communicator = [[InspectableSearchVinylsAPICommunicator alloc] init];
}

- (void)tearDown {
    communicator = nil;
    [super tearDown];
}

- (void)testSearchUrl {
    [communicator searchFor:@"queen" onSuccess:nil onError:nil];
    XCTAssertEqualObjects([communicator fetchedURL], @"http://searchvinyls.appspot.com/api/search?c=queen", @"Wrong fetched URL");
    
}

- (void)testMostWantedUrl {
    [communicator getMostWanted:nil onError:nil];
    XCTAssertEqualObjects([communicator fetchedURL], @"http://searchvinyls.appspot.com/api/mostwanted?", @"Wrong fetched URL");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
