//
//  RequestTestCase.swift
//  RequestTestCase
//
//  Created by Jordan Zucker on 8/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class RequestTestCase: BasicNetworkTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGeneratesEmptyURLRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        let emptyURLRequest = network.generateURLRequest()
        let emptyURLRequest = network.generateURLRequest()
        XCTAssertNotNil(emptyURLRequest)
        XCTAssertEqual(emptyURLRequest.url!.absoluteString, "https://httpbin.org")
    }
    
    func testGeneratesURLWithPath() {
        let emptyURLRequest = network.generateURLRequest(with: "get")
        XCTAssertNotNil(emptyURLRequest)
        XCTAssertEqual(emptyURLRequest.url!.absoluteString, "https://httpbin.org/get")
    }
    
    func testGeneratesURLWithQueryParameters() {
        let emptyURLRequest = network.generateURLRequest(and: ["foo": "bar"])
        XCTAssertNotNil(emptyURLRequest)
        XCTAssertEqual(emptyURLRequest.url!.absoluteString, "https://httpbin.org?foo=bar")
    }
    
    func testGeneratesURLWithPathAndQueryParameters() {
        let emptyURLRequest = network.generateURLRequest(with: "get", and: ["foo": "bar"])
        XCTAssertNotNil(emptyURLRequest)
        XCTAssertEqual(emptyURLRequest.url!.absoluteString, "https://httpbin.org/get?foo=bar")
    }
    
    func testRequestHasNilBodyWhenInitializerIsGivenNilBody() {
        let request = try! Request(body: nil)
        XCTAssertNotNil(request)
        let requestBody = request.body
        XCTAssertNil(requestBody)
        
    }
    
    func testRequestInitializerFailsWhenBodyIsNotData() {
        let body = ["foo", "bar"]
        XCTAssertThrowsError(try Request(body: body))
    }
    
    func testRequestHasDataFromInitializer() {
        let bodyData = Data()
        XCTAssertNotNil(bodyData)
        let request = try! Request(body: bodyData)
        XCTAssertNotNil(request)
        let requestBody = request.body
        XCTAssertNotNil(requestBody)
        XCTAssertEqual(bodyData, requestBody!)
    }
    
//    func testRequestReturnsNilWithNoData() {
//        let request = Request()
//        XCTAssertNotNil(request)
//        XCTAssertNil(try! request.bodyData())
//    }
//    
//    func testRequestReturnsBodyDataForData() {
//        let bodyData = Data()
//        XCTAssertNotNil(bodyData)
//        let request = Request(body: bodyData)
//        XCTAssertNotNil(request)
//        let requestBodyData = try! request.bodyData()
//        XCTAssertEqual(bodyData, requestBodyData)
//    }
    
}
