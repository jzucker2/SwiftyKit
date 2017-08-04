//
//  WeakObjectSet.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/31/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import Foundation

// from https://stackoverflow.com/questions/24127587/how-do-i-declare-an-array-of-weak-references-in-swift
class WeakObject<T: AnyObject>: Equatable, Hashable {
    weak var object: T?
    init(object: T) {
        self.object = object
    }
    
    var hashValue: Int {
        //        Unmanaged.un
        //        if let object = self.object { return unsafeAddressOf(object).hashValue }
        if let object = self.object { return Unmanaged.passUnretained(object).toOpaque().hashValue }
        else { return 0 }
    }
}

func == <T> (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
    return lhs.object === rhs.object
}


class WeakObjectSet<T: AnyObject> {
    var objects: Set<WeakObject<T>>
    
    init() {
        self.objects = Set<WeakObject<T>>([])
    }
    
    init(objects: [T]) {
        self.objects = Set<WeakObject<T>>(objects.map { WeakObject(object: $0) })
    }
    
    var count: Int {
        return allObjects.count
    }
    
    var allObjects: [T] {
        return objects.flatMap { $0.object }
    }
    
    func contains(object: T?) -> Bool {
        guard let actualObject = object else {
            return false
        }
        return self.objects.contains(WeakObject(object: actualObject))
    }
    
    func addObject(object: T) {
        self.objects.formUnion([WeakObject(object: object)])
    }
    
    func removeObject(object: T) {
        guard contains(object: object) else {
            return
        }
        self.objects.remove(WeakObject(object: object))
    }
    
    func addObjects(objects: [T]) {
        self.objects.formUnion(objects.map { WeakObject(object: $0) })
        //        self.objects.unionInPlace(objects.map { WeakObject(object: $0) })
    }
    
    func forEach(body: (WeakObject<T>) -> (Void)) {
        self.objects.forEach(body)
    }
}
