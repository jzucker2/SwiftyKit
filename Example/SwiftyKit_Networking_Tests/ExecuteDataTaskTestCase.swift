//
//  ExecuteDataTaskTestCase.swift
//  SwiftyKit_Networking_Tests
//
//  Created by Jordan Zucker on 10/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class ExecuteDataTaskTestCase: BasicNetworkTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicGETRequest() {
        let request = try! Request(type: .GET, path: "get")
        let expectation = self.expectation(description: "get request")
        XCTAssertNotNil(request)
        try! network.executeDataTask(with: request) { (response, data, error) -> (Void) in
            guard let actualData = data else {
                XCTFail("Expected data")
                return
            }
            do {
                let payload = try JSONSerialization.jsonObject(with: actualData, options: [.allowFragments])
                print("payload: \(payload)")
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testBasicPOSTRequest() {
        let postObject = ["foo":"bar"]
        let postData = try! JSONSerialization.data(withJSONObject: postObject, options: [.prettyPrinted])
        let request = try! Request(type: .POST, body: postData, path: "post")
        XCTAssertNotNil(request)
        let expectation = self.expectation(description: "post request")
        try! network.executeDataTask(with: request) { (response, data, error) -> (Void) in
            guard let actualData = data else {
                XCTFail("Expected data")
                return
            }
            do {
                let payload = try JSONSerialization.jsonObject(with: actualData, options: [.allowFragments]) as! [String:Any]
                print("payload: \(payload)")
                let form = payload["form"] as! [String:String]
                let postObjectResponse = form.keys.first!
                let objectData = postObjectResponse.data(using: .utf8)!
                let objectJSON = try! JSONSerialization.jsonObject(with: objectData, options: [.allowFragments]) as! [String:String]
                XCTAssertEqual(postObject, objectJSON)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testBasicPATCHRequest() {
        let patchObject = ["foo":"bar"]
        let patchData = try! JSONSerialization.data(withJSONObject: patchObject, options: [.prettyPrinted])
        let request = try! Request(type: .PATCH, body: patchData, path: "patch")
        XCTAssertNotNil(request)
        let expectation = self.expectation(description: "patch request")
        try! network.executeDataTask(with: request) { (response, data, error) -> (Void) in
            guard let actualData = data else {
                XCTFail("Expected data")
                return
            }
            do {
                let payload = try JSONSerialization.jsonObject(with: actualData, options: [.allowFragments]) as! [String:Any]
                let dataString = payload["data"] as! String
                let objectData = dataString.data(using: .utf8)!
                let objectJSON = try! JSONSerialization.jsonObject(with: objectData, options: [.allowFragments]) as! [String:String]
                XCTAssertEqual(patchObject, objectJSON)
            } catch {
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
}
