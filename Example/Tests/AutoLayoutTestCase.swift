//
//  AutoLayoutTestCase.swift
//  SwiftyKit_Tests
//
//  Created by Jordan Zucker on 8/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class AutoLayoutTestCase: XCTestCase {
    
    var expectedRect = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
    var baseView: UIView!
    var testView: UIView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        baseView = UIView(frame: expectedRect)
        baseView.layoutIfNeeded()
        XCTAssertNotNil(baseView)
        XCTAssertEqual(baseView.frame, expectedRect)
        
        testView = UIView(frame: .zero)
        baseView.addSubview(testView)
        testView.layoutIfNeeded()
        XCTAssertNotNil(testView)
        XCTAssertEqual(testView.frame, .zero)
        
        XCTAssertTrue(baseView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(testView.translatesAutoresizingMaskIntoConstraints)
        
        XCTAssertEqual(baseView, testView.superview!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForceAutolayout() {
        let abstractTestView = UIView(frame: expectedRect)
        abstractTestView.layoutIfNeeded()
        XCTAssertTrue(abstractTestView.translatesAutoresizingMaskIntoConstraints)
        abstractTestView.forceAutolayout()
        XCTAssertFalse(abstractTestView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func testSizesView() {
        XCTAssertTrue(testView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertNotEqual(testView.frame, baseView.frame)
        XCTAssertNotEqual(testView.frame.size, baseView.frame.size)
        testView.size(to: baseView)
        testView.layoutIfNeeded()
        XCTAssertFalse(testView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(testView.frame.size, baseView.frame.size)
    }
    
    func testCentersView() {
        XCTAssertTrue(testView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertNotEqual(testView.frame, baseView.frame)
        XCTAssertNotEqual(testView.frame.size, baseView.frame.size)
        XCTAssertNotEqual(testView.center, baseView.center)
        testView.center(in: baseView)
        testView.layoutIfNeeded()
        XCTAssertFalse(testView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertNotEqual(testView.center, baseView.center) // Not equal because child view has different zero point from parent
        XCTAssertNotEqual(testView.frame.size, baseView.frame.size)
    }
    
    func testSizesAndCentersView() {
        XCTAssertTrue(testView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertNotEqual(testView.frame, baseView.frame)
        XCTAssertNotEqual(testView.frame.size, baseView.frame.size)
        testView.sizeAndCenter(with: baseView)
        testView.layoutIfNeeded()
        XCTAssertFalse(testView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertNotEqual(testView.frame, baseView.frame) // Not equal because child view has different zero point from parent
        XCTAssertEqual(testView.frame.size, baseView.frame.size)
    }
    
}
