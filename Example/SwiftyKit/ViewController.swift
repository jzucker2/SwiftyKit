//
//  ViewController.swift
//  SwiftyKit
//
//  Created by jzucker2 on 07/27/2017.
//  Copyright (c) 2017 jzucker2. All rights reserved.
//

import UIKit

//@objc protocol Emitting: NSObjectProtocol {
//    associatedtype Root
//    associatedtype Value
//
//    var keyPath: KeyPath<Root, Value> { get }
////    static var partialKeyPath: PartialKeyPath<Root> { get }
////    static var observedKeyPath: KeyPath<Root, Value> { get }
////    static var observedKeyPath: KeyPath<Self, Value> { get }
////    var observedKeyPath: KeyPath<Self, Value> { get }
////    var observedValue: Value? { get }
//}

//extension KeyPath<Root, Value>: Emitting {
//    typealias Root = RootType
//    typealias Value = ValueType
//}

//extension Emitting where Self: NSObject {
//
//}

//extension Emitting where Self: NSObject {
//    typealias Root = Self
//}

//@objc protocol Observing: NSObjectProtocol {
////    associatedtype Observer
//    var observation: NSKeyValueObservation? { get set }
//}
//
//class ChangeObserver<Root: Emitting, Value>: NSObject {
//    var observation: NSKeyValueObservation?
//
//    required init(observe: Root) {
////        self.observation = observe.observe(<#T##keyPath: KeyPath<Root, Value>##KeyPath<Root, Value>#>, options: <#T##NSKeyValueObservingOptions#>, changeHandler: <#T##(Root, NSKeyValueObservedChange<Value>) -> Void#>)
//        super.init()
//    }
//
//}

//
////extension Emitting {
////
////}
//
////@objc protocol Reacting: NSObjectProtocol {
////    associatedtype Object: Emitting
////    static var responseSelectors: [String] { get }
////
////    //    static var responseKeyPaths: [KeyPath<Object, Value>] { get }
////}
//
//@objc protocol Observing: NSObjectProtocol {
////    associatedtype Reactor: Reacting
//    //    associatedtype Reactor: Reacting
//    var observation: NSKeyValueObservation? { get set }
//    //    var responseSelectors: [String] { get }
//
////    var reactor: Reactor? { get set }
//
//}
//
//extension Observing {
//
//
//}
//
//class Observer<Root: Emitting, Value>: NSObject /*where Root.Value == Value*/ {
//
//    var observation: NSKeyValueObservation?
//
//    required override init() {
//        super.init()
//    }
////    var reactor: Reactor?
////    var reactor: Actor?
//
////    required init(reactor: Actor) {
////        self.reactor = reactor
////        super.init()
////    }
//
//
//}
//
//extension Observer: Observing {
//
//
//}
//
////extension Observing {
////
////    typealias Reactor = Actor
////
////}
//
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

//extension Emitter: Emitting {
//
//    typealias Value = Int
//    typealias Root = Emitter
//
//    //    var observedValue: Int? {
//    //        return \Emitter.count
//    //    }
//
////    static var observedKeyPath: KeyPath<Emitter, Int> {
////        return \Emitter.count
////    }
//    
////    static var observedKeyPath: PartialKeyPath<Root> {
//////        return Emitter.ob
////        return PartialKeyPath<Emitter>
////    }
//    static var observedKeyPath: KeyPath<Emitter, Int> {
//        return \Emitter.count
//    }
//
//}
//
//class TestObserver: NSObject {
//
//    var observer: Observer<Emitter, Int>?
//
//    @objc dynamic var emitter: Emitter
//
//    private(set) var latestValue = 0
//
//    required init(emitter: Emitter) {
//        self.emitter = emitter
//        super.init()
//    }
//
//    @objc func updateEmitter(with value: NSNumber) {
//        print("********** value: \(value)")
//        latestValue = value.intValue
//    }
//
//}
//
////extension TestObserver: Reacting {
////
////    static var responseSelectors: [String] {
////        return ["Whatever"]
////    }
////
////}

class ViewController: UIViewController {
    
//    let testEmitter = Emitter()
//    var observingObject: TestObserver?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        observingObject = TestObserver(emitter: testEmitter)
        
//        let startTestBlockPrint = "Start test block"
//        print(startTestBlockPrint)
//        print(testEmitter.increment())
//        print(observingObject?.latestValue as Any)
//        print(testEmitter.increment())
//        print(observingObject?.latestValue as Any)
//        print("hello, world!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

