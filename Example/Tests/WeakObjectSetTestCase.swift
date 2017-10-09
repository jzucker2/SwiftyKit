//
//  WeakObjectSetTestCase.swift
//  SwiftyKit_Tests
//
//  Created by Jordan Zucker on 8/4/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class WeakObjectSetTestCase: XCTestCase {
    
    class Test: NSObject {
        var value: Int
        required init(value: Int) {
            self.value = value
            super.init()
        }
    }

    var testSet: WeakObjectSet<Test> = WeakObjectSet()
    var firstTestObject: Test? = Test(value: 0)
    var secondTestObject: Test? = Test(value: 1)
    
    func addObjectActivity(with object: Test?) {
        XCTContext.runActivity(named: "Add Object") { (activity) in
            XCTAssertNotNil(testSet)
            guard let actualObject = object else {
                XCTFail("Expected object")
                return
            }
            let originalCount = testSet.count
            self.testSet.addObject(object: actualObject)
            XCTAssertEqual(testSet.count, originalCount + 1)
        }
    }
    
    func addObjectActivity(multiple objects: [Test?]) {
        XCTContext.runActivity(named: "Add Multiple Objects") { (activity) in
            XCTAssertNotNil(testSet)
            XCTAssertEqual(testSet.count, 0)
            var addedObjects = 0
            objects.forEach({ (testObject) in
                addObjectActivity(with: testObject)
                addedObjects += 1
            })
            XCTAssertEqual(testSet.count, addedObjects)
        }
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        XCTAssertNotEqual(firstTestObject!, secondTestObject!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCount() {
        addObjectActivity(with: firstTestObject)
    }
    
    func testAddObject() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        addObjectActivity(with: firstTestObject)
    }
    
    func testContainsObject() {
        XCTAssertFalse(testSet.contains(object: firstTestObject))
        addObjectActivity(with: firstTestObject)
        XCTAssertTrue(testSet.contains(object: firstTestObject))
        XCTAssertFalse(testSet.contains(object: secondTestObject))
    }
    
    func testRemoveObject() {
        addObjectActivity(with: firstTestObject)
        testSet.removeObject(object: firstTestObject!)
        XCTAssertEqual(testSet.count, 0)
        XCTAssertFalse(testSet.contains(object: firstTestObject))
    }
    
    func testAddMultipleObjects() {
        XCTAssertEqual(testSet.count, 0)
        XCTAssertFalse(testSet.contains(object: firstTestObject))
        XCTAssertFalse(testSet.contains(object: secondTestObject))
        addObjectActivity(multiple: [firstTestObject, secondTestObject])
        XCTAssertEqual(testSet.count, 2)
        XCTAssertTrue(testSet.contains(object: firstTestObject))
        XCTAssertTrue(testSet.contains(object: secondTestObject))

    }
    
    func testHoldWeakReferenceToObjects() {
        XCTAssertNotNil(firstTestObject)
        addObjectActivity(with: firstTestObject)
        firstTestObject = nil
        XCTAssertNil(firstTestObject)
        XCTAssertEqual(testSet.count, 0)
        print(testSet.allObjects)
        print(testSet.objects)
    }
    
    func testForEach() {
        addObjectActivity(multiple: [firstTestObject, secondTestObject])
        XCTAssertEqual(testSet.count, 2)
        XCTAssertTrue(testSet.contains(object: firstTestObject))
        XCTAssertTrue(testSet.contains(object: secondTestObject))
        
        testSet.forEach { (testObject) -> (Void) in
            guard let actualTestObject = testObject else {
                XCTFail("We should always have a value in this test")
                return
            }
            // Why do these throw warnings? Either way this is a smoke test at least
//            XCTAssertTrue(actualTestObject is Test)
//            XCTAssertTrue(actualTestObject.value is Int)
            XCTAssertTrue((actualTestObject.value == 0) || (actualTestObject.value == 1))
//            XCTAssertEqual(type(of: actualTestObject), Test.self)
//            XCTAssertEqual(type(of: actualTestObject.value), Int.self)
        }
    }
    
}
