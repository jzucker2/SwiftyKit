//
//  ObservationTestCase.swift
//  SwiftyKit_Tests
//
//  Created by Jordan Zucker on 7/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest



class ObservationTestCase: XCTestCase {
    
    @objc class Emitter: NSObject {
        
        @objc dynamic private(set) var count: Int = 0
        
        func reset() {
            count = 0
        }
        
        func increment() -> Int {
            count += 1
            return count
        }
        
    }
    
    let emmitter = Emitter()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
