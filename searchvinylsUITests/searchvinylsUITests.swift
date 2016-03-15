//
//  searchvinylsUITests.swift
//  searchvinylsUITests
//
//  Created by Daniel Vela on 15/03/16.
//  Copyright © 2016 veladan. All rights reserved.
//

import XCTest

class searchvinylsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLaunch() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        XCTAssertGreaterThan( app.tables.cells.count, 0, "Most wanted not loaded")
    }
    
    func testMostWantedClicked() {
        let app = XCUIApplication()

        app.tables.cells.staticTexts["Nirvana"].tap()


        XCTAssertGreaterThan( app.tables.cells.count, 0, "Resutls from most wanted not loaded")
    }
    
    func testSearch() {
        let app = XCUIApplication()

        let typeHereToSearchTextField = app.textFields["Type here to search..."]
        XCTAssertTrue(typeHereToSearchTextField.exists)
        typeHereToSearchTextField.tap()
        typeHereToSearchTextField.typeText("sting")
        app.typeText("\r")

        sleep(3)
        XCTAssertGreaterThan( app.tables.cells.count, 0, "Resutls from search not loaded")
    }
}
