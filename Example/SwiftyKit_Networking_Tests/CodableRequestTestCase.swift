//
//  CodableRequestTestCase.swift
//  SwiftyKit_Networking_Tests
//
//  Created by Jordan Zucker on 10/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class CodableRequestTestCase: BasicNetworkTestCase {
    
    class TestObject: Remote, Codable {
        static var service: String {
            return "users"
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
    
    func testRequestHasJSONContentTypeHeaderWithNoParametersInInitializer() {
        let request = try! CodableRequest<TestObject>()
        let headers = request.headers
        XCTAssertNotNil(headers)
        XCTAssertEqual(headers!["Content-Type"], "application/json")
    }
    
    func testRequestHasJSONContentTypeWithOtherHeaders() {
        let headers = [
            "Accept-Language": "en-us"
        ]
        let request = try! CodableRequest<TestObject>(headers: headers)
        XCTAssertNotNil(request)
        let requestHeaders = request.headers
        XCTAssertNotNil(requestHeaders)
        XCTAssertEqual(requestHeaders!["Content-Type"], "application/json")
        XCTAssertEqual(requestHeaders!["Accept-Language"], "en-us")
    }
    
    func testRequestOverwritesHeadersToBeJSONContentType() {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        XCTAssertNotEqual(headers["Content-Type"], "application/json")
        let request = try! CodableRequest<TestObject>(headers: headers)
        XCTAssertNotNil(request)
        let requestHeaders = request.headers
        XCTAssertNotNil(requestHeaders)
        XCTAssertEqual(requestHeaders!["Content-Type"], "application/json")
    }
    
    func testRequestHasNilBodyWhenInitializerIsGivenNilBody() {
        let request = try! CodableRequest<TestObject>(body: nil)
        XCTAssertNotNil(request)
        let requestBody = request.body
        XCTAssertNil(requestBody)
        
    }
    
    func testRequestInitializerPassesDataThrough() {
        let initialObject = ["foo": "bar"]
        let expectedData = try! JSONSerialization.data(withJSONObject: initialObject, options: [.prettyPrinted])
        XCTAssertNotNil(expectedData)
        let request = try! CodableRequest<TestObject>(body: initialObject)
        XCTAssertNotNil(request)
        let requestBody = request.body
        XCTAssertNotNil(requestBody)
        XCTAssertEqual(expectedData, requestBody!)
    }
    
    func testRequestConvertsJSONObjectToDataFromInitializer() {
        let initialObject = ["foo": "bar"]
        let expectedData = try! JSONSerialization.data(withJSONObject: initialObject, options: [.prettyPrinted])
        XCTAssertNotNil(expectedData)
        let request = try! CodableRequest<TestObject>(body: initialObject)
        XCTAssertNotNil(request)
        let requestBody = request.body
        XCTAssertNotNil(requestBody)
        XCTAssertEqual(expectedData, requestBody!)
    }
    
    func testRequestConvertsCodableObjectToDataFromInitializer() {
        let initialObject = TestObject()
        let encoder = JSONEncoder()
        let expectedData = try! encoder.encode(initialObject)
        XCTAssertNotNil(expectedData)
        let request = try! CodableRequest<TestObject>(body: initialObject)
        XCTAssertNotNil(request)
        let requestBody = request.body
        XCTAssertNotNil(requestBody)
        XCTAssertEqual(expectedData, requestBody!)
    }
    
}
