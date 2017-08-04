//
//  StackingViewTestCase.swift
//  SwiftyKit_Tests
//
//  Created by Jordan Zucker on 8/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class StackingViewTestCase: XCTestCase {
    
    struct TestScreen: Screen {
        var bounds: CGRect {
            return CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        }
    }
    
    class TestStackedView: UIViewController, StackingView {
        let stackView = UIStackView(frame: .zero)
        let testScreen: Screen
        
        required init(screen: TestScreen) {
            self.testScreen = screen
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = loadedView(and: self.testScreen)
        }
    }
    
    class TestNonDefaultOptionsStackedView: UIViewController, StackingView {
        let stackView = UIStackView(frame: .zero)
        let testScreen: Screen
        
        required init(screen: TestScreen) {
            self.testScreen = screen
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = loadedView(and: self.testScreen)
        }
        
        static var stackViewOptions: StackViewOptions {
            return StackViewOptions(axis: .horizontal, alignment: .center, distribution: .equalCentering, backgroundColor: .red)
        }
    }
    
    let testScreen = TestScreen()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStackViewExistsWithLoadViewConvenience() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testStackedView = TestStackedView(screen: self.testScreen)
        XCTAssertNotNil(testStackedView)
        testStackedView.loadViewIfNeeded()
        testStackedView.view.layoutIfNeeded()
        print(testStackedView.view.frame)
        print(testStackedView.stackView.frame)
        XCTAssertNotNil(testStackedView.stackView)
        XCTAssertEqual(testScreen.bounds, testStackedView.view.frame)
        XCTAssertEqual(testScreen.bounds, testStackedView.stackView.frame)
        XCTAssertEqual(testStackedView.view, testStackedView.stackView.superview!)
    }
    
    func testDefaultOptions() {
        let defaultOptions = StackViewOptions.defaultOptions()
        XCTAssertEqual(defaultOptions.axis, .vertical)
        XCTAssertEqual(defaultOptions.alignment, .fill)
        XCTAssertEqual(defaultOptions.distribution, .fill)
        XCTAssertEqual(defaultOptions.backgroundColor, .white)
    }
    
    func testStackingAppliesDefaultOptions() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testStackedView = TestStackedView(screen: self.testScreen)
        XCTAssertNotNil(testStackedView)
        testStackedView.loadViewIfNeeded()
        testStackedView.view.layoutIfNeeded()
        XCTAssertNotNil(testStackedView.stackView)
        let defaultOptions = StackViewOptions.defaultOptions()
        XCTAssertEqual(testStackedView.stackView.axis, defaultOptions.axis)
        XCTAssertEqual(testStackedView.stackView.distribution, defaultOptions.distribution)
        XCTAssertEqual(testStackedView.stackView.alignment, defaultOptions.alignment)
        XCTAssertEqual(testStackedView.view.backgroundColor, defaultOptions.backgroundColor)
    }
    
    func testAppliesSubclassOverrideStackViewOptions() {
        let testStackedView = TestNonDefaultOptionsStackedView(screen: self.testScreen)
        XCTAssertNotNil(testStackedView)
        testStackedView.loadViewIfNeeded()
        testStackedView.view.layoutIfNeeded()
        let stackView = testStackedView.stackView
        XCTAssertNotNil(stackView)
        let differentOptions = TestNonDefaultOptionsStackedView.stackViewOptions
        
        XCTAssertEqual(stackView.axis, .horizontal)
        XCTAssertEqual(stackView.axis, differentOptions.axis)
        
        XCTAssertEqual(stackView.distribution, .equalCentering)
        XCTAssertEqual(stackView.distribution, differentOptions.distribution)
        
        XCTAssertEqual(stackView.alignment, .center)
        XCTAssertEqual(stackView.alignment, differentOptions.alignment)
        
        XCTAssertEqual(testStackedView.view.backgroundColor, .red)
        XCTAssertEqual(testStackedView.view.backgroundColor, differentOptions.backgroundColor)
    }
    
}
