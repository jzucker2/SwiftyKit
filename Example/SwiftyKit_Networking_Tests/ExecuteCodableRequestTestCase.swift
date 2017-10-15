//
//  ExecuteCodableRequestTestCase.swift
//  SwiftyKit_Networking_Tests
//
//  Created by Jordan Zucker on 10/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class ExecuteCodableRequestTestCase: BasicNetworkTestCase {
    
    struct TestObject: Remote, Codable, Equatable {
        static var service: String {
            return "get"
        }
        let headers: [String:String]
        let origin: String
        let url: String
        
        static var expectedGETResult: TestObject {
            let headers: [String:String] = [
                "Content-Type": "application/json",
                "Connection": "close",
                "Host": "httpbin.org",
                "Accept": "*/*",
                "User-Agent": "xctest (unknown version) CFNetwork/887 Darwin/16.7.0",
                "Accept-Language": "en-us",
                "Accept-Encoding": "br, gzip, deflate"
            ]
            return TestObject(headers: headers, origin: "73.71.236.43", url: "https://httpbin.org/get")
        }
        
        static func == (lhs: TestObject, rhs: TestObject) -> Bool {
            return (lhs.origin == rhs.origin) && (lhs.url == rhs.url) && (lhs.headers == rhs.headers)
        }
        
    }
    
    struct POSTTestObject: Remote, Codable, Equatable {
        static var service: String {
            return "post"
        }
        let headers: [String:String]
        let origin: String
        let url: String
        
        static var expectedPOSTResult: POSTTestObject {
            let headers: [String:String] = [
                "Content-Type": "application/json",
                "Connection": "close",
                "Host": "httpbin.org",
                "Accept": "*/*",
                "Content-Length": "323",
                "User-Agent": "xctest (unknown version) CFNetwork/887 Darwin/16.7.0",
                "Accept-Language": "en-us",
                "Accept-Encoding": "br, gzip, deflate",
            ]
            return POSTTestObject(headers: headers, origin: "73.71.236.43", url: "https://httpbin.org/post")
        }
        
        static func == (lhs: POSTTestObject, rhs: POSTTestObject) -> Bool {
            return (lhs.origin == rhs.origin) && (lhs.url == rhs.url) && (lhs.headers == rhs.headers)
        }
        
    }
    
    struct PATCHTestObject: Remote, Codable, Equatable {
        static var service: String {
            return "patch"
        }
        let headers: [String:String]
        let origin: String
        let url: String
        
        static var expectedPATCHResult: PATCHTestObject {
            let headers: [String:String] = [
                "Content-Type": "application/json",
                "Connection": "close",
                "Host": "httpbin.org",
                "Accept": "*/*",
                "Content-Length": "324",
                "User-Agent": "xctest (unknown version) CFNetwork/887 Darwin/16.7.0",
                "Accept-Language": "en-us",
                "Accept-Encoding": "br, gzip, deflate",
                ]
            return PATCHTestObject(headers: headers, origin: "73.71.236.43", url: "https://httpbin.org/patch")
        }
        
        static func == (lhs: PATCHTestObject, rhs: PATCHTestObject) -> Bool {
            return (lhs.origin == rhs.origin) && (lhs.url == rhs.url) && (lhs.headers == rhs.headers)
        }
        
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicGETRequest() {
        let expectedResult = TestObject.expectedGETResult
        let request = try! CodableRequest<TestObject>(type: .GET)
        let expectation = self.expectation(description: "get request")
        XCTAssertNotNil(request)
        try! network.executeCodableTask(with: request, and: { (response, object, error) -> (Void) in
            guard let actualObject = object else {
                XCTFail("Expected object")
                return
            }
            print("response: \(String(describing: response))")
            print("payload: \(actualObject)")
            XCTAssertNotNil(actualObject)
            XCTAssertEqual(actualObject, expectedResult)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testBasicPOSTRequest() {
        let expectedResult = POSTTestObject.expectedPOSTResult
        let request = try! CodableRequest<POSTTestObject>(type: .POST, body: expectedResult)
        let expectation = self.expectation(description: "post request")
        XCTAssertNotNil(request)
        try! network.executeCodableTask(with: request, and: { (response, object, error) -> (Void) in
            guard let actualObject = object else {
                XCTFail("Expected object")
                return
            }
            print("response: \(String(describing: response))")
            print("payload: \(actualObject)")
            XCTAssertNotNil(actualObject)
            XCTAssertEqual(actualObject, expectedResult)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testBasicPATCHRequest() {
        let expectedResult = PATCHTestObject.expectedPATCHResult
        let request = try! CodableRequest<PATCHTestObject>(type: .PATCH, body: expectedResult)
        let expectation = self.expectation(description: "patch request")
        XCTAssertNotNil(request)
        try! network.executeCodableTask(with: request, and: { (response, object, error) -> (Void) in
            guard let actualObject = object else {
                XCTFail("Expected object")
                return
            }
            print("response: \(String(describing: response))")
            print("payload: \(actualObject)")
            XCTAssertNotNil(actualObject)
            XCTAssertEqual(actualObject, expectedResult)
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }
    }
    
}
