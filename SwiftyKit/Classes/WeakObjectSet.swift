//
//  WeakObjectSet.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/31/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import Foundation

// from https://stackoverflow.com/questions/24127587/how-do-i-declare-an-array-of-weak-references-in-swift
public class WeakObject<T: AnyObject>: Equatable, Hashable {
    weak var object: T?
    public init(object: T) {
        self.object = object
    }
    
    public var hashValue: Int {
        if let object = self.object { return Unmanaged.passUnretained(object).toOpaque().hashValue }
        else { return 0 }
    }
}

public func == <T> (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
    return lhs.object === rhs.object
}


public class WeakObjectSet<T: AnyObject> {
    public var objects: Set<WeakObject<T>>
    
    public init() {
        self.objects = Set<WeakObject<T>>([])
    }
    
    public init(objects: [T]) {
        self.objects = Set<WeakObject<T>>(objects.map { WeakObject(object: $0) })
    }
    
    public var count: Int {
        return allObjects.count
    }
    
    public var allObjects: [T] {
        return objects.flatMap { $0.object }
    }
    
    public func contains(object: T?) -> Bool {
        guard let actualObject = object else {
            return false
        }
        return self.objects.contains(WeakObject(object: actualObject))
    }
    
    public func addObject(object: T) {
        self.objects.formUnion([WeakObject(object: object)])
    }
    
    public func removeObject(object: T) {
        guard contains(object: object) else {
            return
        }
        self.objects.remove(WeakObject(object: object))
    }
    
    public func addObjects(objects: [T]) {
        self.objects.formUnion(objects.map { WeakObject(object: $0) })
        //        self.objects.unionInPlace(objects.map { WeakObject(object: $0) })
    }
    
    public func forEach(body: (T?) -> (Void)) {
        self.objects.forEach { (weakObject) in
            body(weakObject.object)
        }
    }
}
