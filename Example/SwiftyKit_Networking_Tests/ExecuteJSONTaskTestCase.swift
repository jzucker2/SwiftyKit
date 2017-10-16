//
//  ExecuteJSONTaskTestCase.swift
//  SwiftyKit_Networking_Tests
//
//  Created by Jordan Zucker on 10/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class ExecuteJSONTaskTestCase: BasicNetworkTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicGETRequest() {
        let request = try! JSONRequest(type: .GET, path: "get")
        let expectation = self.expectation(description: "get request")
        XCTAssertNotNil(request)
        try! network.executeJSONTask(with: request) { (response, object, error) -> (Void) in
            guard let actualObject = object else {
                XCTFail("Expected object")
                return
            }
            print("payload: \(actualObject)")
            XCTAssertNotNil(actualObject)
            XCTAssertFalse(actualObject is Data)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testBasicPOSTRequest() {
        let initialPostObject = ["foo": "bar"]
        let request = try! JSONRequest(type: .POST, body: initialPostObject, path: "post")
        let expectation = self.expectation(description: "post request")
        XCTAssertNotNil(request)
        try! network.executeJSONTask(with: request) { (response, object, error) -> (Void) in
            guard let actualObject = object else {
                XCTFail("Expected object")
                return
            }
            print("payload: \(actualObject)")
            XCTAssertNotNil(actualObject)
            XCTAssertFalse(actualObject is Data)
            let payload = actualObject as! [String:Any]
            let dataString = payload["data"] as! String
            let objectData = dataString.data(using: .utf8)!
            let objectJSON = try! JSONSerialization.jsonObject(with: objectData, options: [.allowFragments]) as! [String:String]
            XCTAssertEqual(initialPostObject, objectJSON)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testBasicPATCHRequest() {
        let initialPatchObject = ["foo": "bar"]
        let request = try! JSONRequest(type: .PATCH, body: initialPatchObject, path: "patch")
        let expectation = self.expectation(description: "patch request")
        XCTAssertNotNil(request)
        try! network.executeJSONTask(with: request) { (response, object, error) -> (Void) in
            guard let actualObject = object else {
                XCTFail("Expected object")
                return
            }
            print("payload: \(actualObject)")
            XCTAssertNotNil(actualObject)
            XCTAssertFalse(actualObject is Data)
            let payload = actualObject as! [String:Any]
            let dataString = payload["data"] as! String
            let objectData = dataString.data(using: .utf8)!
            let objectJSON = try! JSONSerialization.jsonObject(with: objectData, options: [.allowFragments]) as! [String:String]
            XCTAssertEqual(initialPatchObject, objectJSON)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
}
