//
//  ViewControllerTests.m
//  searchvinyls
//
//  Created by Daniel Vela on 24/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewControllerTests : XCTestCase {
    ViewController* controller;
}

@end

@implementation ViewControllerTests

- (void)setUp {
    [super setUp];
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    controller = (ViewController*)delegate.window.rootViewController;
}

- (void)tearDown {
    controller = nil;
    [super tearDown];
}

- (void)testViewDidLoad {
    XCTAssertNotNil(controller,@"ViewController was not instantiated");
}



@end
