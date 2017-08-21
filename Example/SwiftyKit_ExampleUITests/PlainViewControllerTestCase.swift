//
//  PlainViewControllerTestCase.swift
//  SwiftyKit_ExampleUITests
//
//  Created by Jordan Zucker on 8/1/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

class PlainViewControllerTestCase: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//        XCTContext.runActivity(named: "Go To Plain View Tab") { (activity) in
//            let app = XCUIApplication()
//            let errorTab = app.tabBars.buttons["Errors"]
//            XCTAssertTrue(errorTab.exists)
//            errorTab.tap()
//            let alertErrorButton = app.buttons["Alert Controller Error"]
//            let navErrorButton = app.buttons["Navigation Prompt Error"]
//            XCTAssertTrue(alertErrorButton.exists)
//            XCTAssertTrue(navErrorButton.exists)
//            let screenshot = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
//            activity.add(screenshot)
//        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
