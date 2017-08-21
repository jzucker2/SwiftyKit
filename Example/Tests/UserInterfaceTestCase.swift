//
//  UserInterfaceTestCase.swift
//  SwiftyKit_Tests
//
//  Created by Jordan Zucker on 8/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class UserInterfaceTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReuseIdentifier() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let view1 = UIView(frame: .zero)
        let view2 = UIView(frame: CGRect(x: 5.0, y: 5.0, width: 5.0, height: 5.0))
        XCTAssertNotEqual(view1, view2)
        
        let view1Reuse = type(of: view1).reuseIdentifier()
        XCTAssertEqual(view1Reuse, type(of: view2).reuseIdentifier())
        XCTAssertEqual(view1Reuse, NSStringFromClass(type(of: view1)))
        
        let buttonView = UIButton(type: .system)
        let buttonViewReuse = type(of: buttonView).reuseIdentifier()
        XCTAssertNotEqual(view1Reuse, buttonViewReuse)
        XCTAssertNotEqual(view1Reuse, buttonViewReuse)
    }
    
}
