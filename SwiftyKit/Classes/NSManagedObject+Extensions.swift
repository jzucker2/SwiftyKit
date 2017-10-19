//
//  NSManagedObject+Extensions.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/24/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import CoreData

extension NSManagedObject {
    public func refresh(_ mergeChanges: Bool = true) {
        managedObjectContext?.refresh(self, mergeChanges: mergeChanges)
    }
}
