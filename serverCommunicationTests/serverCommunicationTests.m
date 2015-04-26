//
//  serverCommunicationTests.m
//  serverCommunicationTests
//
//  Created by Daniel Vela on 24/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SearchVinylsAPICommunicator.h"

@interface serverCommunicationTests : XCTestCase {
    SearchVinylsAPICommunicator* communicator;
}

@end

@implementation serverCommunicationTests

- (void)setUp {
    [super setUp];
    communicator = [[SearchVinylsAPICommunicator alloc] init];
}

- (void)tearDown {
    communicator = nil;
    [super tearDown];
}

- (void)testSearchUrl {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Search Response"];

    [communicator searchFor:@"queen" onSuccess:^(NSArray* response){
        XCTAssertNotNil(response);
        [expectation fulfill];
    }onError:^(NSError* error){
        XCTAssert(false, @"Not tested. Check connection and relaunch tests");
        [expectation fulfill];
    }];
   

    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError *error) {
                                     // handler is called on _either_ success or failure
                                     if (error != nil) {
                                         XCTFail(@"timeout error: %@", error);
                                     }
                                 }];
}

- (void)testMostWantedUrl {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Search Response"];
    
    [communicator getMostWanted:^(NSArray* response){
        XCTAssertNotNil(response);
        XCTAssert([response count] == 5, @"Server must return 5 most wanted resutls");
        [expectation fulfill];
    }onError:^(NSError* error){
        XCTAssert(false, @"Not tested. Check connection and relaunch tests");
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10
                                 handler:^(NSError *error) {
                                     // handler is called on _either_ success or failure
                                     if (error != nil) {
                                         XCTFail(@"timeout error: %@", error);
                                     }
                                 }];
}



@end
