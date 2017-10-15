//
//  BasicNetworkTestCase.swift
//  SwiftyKit_Networking_Tests
//
//  Created by Jordan Zucker on 10/15/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import DVR
@testable import SwiftyKit

class BasicNetworkTestCase: XCTestCase {
    
    class TestNetwork: Network {
        let operationQueue = OperationQueue()
        
        let host: String = "https://httpbin.org"
        
        let session: URLSession
        
        required init(name: String) {
//            let config = URLSessionConfiguration.ephemeral
//            self.session = URLSession(configuration: config, delegate: nil, delegateQueue: operationQueue)
            let dvrSession = Session(cassetteName: name)
//            dvrSession.recordingEnabled = false
            self.session = dvrSession
            
        }
    }
    
    var network = TestNetwork(name: "Example")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.network = TestNetwork(name: name)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
