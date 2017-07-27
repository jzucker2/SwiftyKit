//
//  Observation.swift
//  Pods-SwiftyKit_Example
//
//  Created by Jordan Zucker on 7/27/17.
//

import UIKit

//protocol Emitting: class, NSObjectProtocol {
//    
//}
//
//protocol Reacting: class, NSObjectProtocol {
//    associatedtype Object
//    associatedtype Value
//    static var responseSelectors: [Selector] { get }
//    static var responseKeyPaths: [KeyPath<Object, Value>] { get }
//}
//
//class Observer<Root: NSObject>: NSObject {
//    
//    var observation: NSKeyValueObservation?
//    
//    var responseSelectors: [Selector] = [Selector]()
//        
//    weak var reactor: (Reacting & NSObject)?
//    
//    typealias ObservationBlock<T> = (Root, NSKeyValueObservedChange<T>) -> (Void)
//    
//    func addObservation<Value>(for object: Root, with observingKeyPath: KeyPath<Root, Value>, and reaction: ObservationBlock<Value>? = nil) -> NSKeyValueObservation {
//        observation = object.observe(observingKeyPath, options: [.new, .old, .initial], changeHandler: { (changedObject, change) in
//            print("changed!!!!!!!!!")
//            guard let actualReactor = self.reactor else {
//                print("no actualReactor")
//                return
//            }
//            type(of: actualReactor).responseSelectors.forEach({ (selector) in
//                //                self.reactor?.perform(selector)
//                //                actualReactor.perform(selector, with: 1)
//                guard let reactorObject = self.reactor else {
//                    fatalError("How did we go wrong?")
//                }
//                let value = changedObject[keyPath: observingKeyPath] as! Int
//                print("reactorObject: \(reactorObject)")
//                print("$$$$$$$$$$$$$$$$$$$$ changed value $$$$$$$$$$$$$$$$$$$$ value: \(value)")
//                print("changedObject: \(changedObject.debugDescription)")
//                let numberValue = NSNumber(integerLiteral: value)
//                print("numberValue: \(numberValue)")
//            })
//            //            self.responseSelectors.forEach({ (selector) in
//            ////                self.reactor?.perform(selector)
//            //                guard let reactorObject = self.reactor as? NSObject else {
//            //                    fatalError("How did we go wrong?")
//            //                }
//            //                reactorObject.perform(selector)
//            //            })
//            reaction?(changedObject, change)
//        })
//        guard let actualObservation = observation else {
//            fatalError()
//        }
//        return actualObservation
//    }
//    
//    static func createObserver<Value>(for object: Root, applyingTo reactor: NSObject & Reacting, with keyPath: KeyPath<Root, Value>, and reaction: ObservationBlock<Value>? = nil) -> Observer<Root> {
//        let creatingObserver = Observer()
//        creatingObserver.reactor = reactor
//        creatingObserver.addObservation(for: object, with: keyPath, and: reaction)
//        //        creatingObserver.addObservation(for: object, with: keyPath)
//        //        creatingObserver
//        return creatingObserver
//    }
//    
//    func add(response selectors: [Selector]) {
//        responseSelectors = selectors
//    }
//}
//
//@objc class Emitter: NSObject {
//    
//    @objc dynamic private(set) var count: Int = 0
//    
//    func reset() {
//        count = 0
//    }
//    
//    func increment() -> Int {
//        count += 1
//        return count
//    }
//    
//}
//
//class TestObserver: NSObject {
//    
//    var observer: Observer<Emitter>?
//    
//    @objc dynamic var emitter: Emitter
//    
//    private(set) var latestValue = 0
//    
//    required init(emitter: Emitter) {
//        self.emitter = emitter
//        super.init()
//        //        self.observer = Observer.createObserver(for: emitter, with: \Emitter.count)
//        self.observer = Observer.createObserver(for: emitter, applyingTo: self, with: \Emitter.count, and: { (changedEmitter, change) -> (Void) in
//            print("changedEmitter: \(changedEmitter.debugDescription)")
//            print("change: \(change)")
//        })
//    }
//    
//    @objc func updateEmitter(with value: NSNumber) {
//        print("********** value: \(value)")
//        latestValue = value.intValue
//    }
//    
//}
//
//extension TestObserver: Reacting {
//    
//    static var responseSelectors: [Selector] {
//        print("responseSelectors")
//        return [
//            #selector(TestObserver.updateEmitter(with:))
//        ]
//    }
//    
//}

