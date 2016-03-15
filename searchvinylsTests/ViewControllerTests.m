//
//  ViewControllerTests.m
//  searchvinyls
//
//  Created by Daniel Vela on 24/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MainViewController.h"
#import "AppDelegate.h"
@import ObjectiveC;

@interface ViewControllerTests : XCTestCase {
    MainViewController* controller;
}

@end

@implementation ViewControllerTests

- (void)setUp {
    [super setUp];
    controller = [[MainViewController alloc] init];
}

- (void)tearDown {
    controller = nil;
    [super tearDown];
}

- (void)testViewDidLoad {
    XCTAssertNotNil(controller,@"ViewController was not created");
}

- (void)testViewControllerHasATableViewProperty {
    Ivar tableViewProperty = class_getInstanceVariable([controller class], "_mostWantedController");
    XCTAssertTrue(tableViewProperty != NULL, @"ViewController needs a table view");
}

- (void)testViewControllerHasAInputFieldProperty {
    objc_property_t property = class_getProperty([controller class], "inputField");
    XCTAssertTrue(property != NULL, @"ViewController needs a input field");
}

- (void)testViewControllerHasAPositionForTVProperty {
    objc_property_t property = class_getProperty([controller class], "positionForTV");
    XCTAssertTrue(property != NULL, @"ViewController needs a view for inserting the table of MostWantedTableViewController");
}

@end
