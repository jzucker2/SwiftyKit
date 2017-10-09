//
//  BasicNetworkProtocolTestCase.swift
//  BasicNetworkProtocolTestCase
//
//  Created by Jordan Zucker on 8/21/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import SwiftyKit

class BasicNetworkProtocolTestCase: XCTestCase {
    
    class TestNetwork: Network {
        let operationQueue = OperationQueue()
        
        let host: String = "https://httpbin.org"
        
        let session: URLSession
        
        required init() {
            let config = URLSessionConfiguration.ephemeral
            self.session = URLSession(configuration: config, delegate: nil, delegateQueue: operationQueue)
        }
    }
    
    let network = TestNetwork()
    
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
        XCTAssertEqual(emptyURLRequest.url!.absoluteString, "https://httpbin.org/get/")
    }
    
    func testGeneratesURLWithQueryParameters() {
        let emptyURLRequest = network.generateURLRequest(and: ["foo": "bar"])
        XCTAssertNotNil(emptyURLRequest)
        XCTAssertEqual(emptyURLRequest.url!.absoluteString, "https://httpbin.org?foo=bar")
    }
    
    func testGeneratesURLWithPathAndQueryParameters() {
        let emptyURLRequest = network.generateURLRequest(with: "get", and: ["foo": "bar"])
        XCTAssertNotNil(emptyURLRequest)
        XCTAssertEqual(emptyURLRequest.url!.absoluteString, "https://httpbin.org/get/?foo=bar")
    }
    
}
