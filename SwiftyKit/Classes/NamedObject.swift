//
//  NamedObject.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/25/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import UIKit
import CoreData

public protocol NamedObject: class {
    var name: String? { get set }
    func nameChangeAlertController(in context: NSManagedObjectContext, with completion: @escaping NameChangeAlertCompletion) -> UIAlertController
}

public typealias NameChangeAlertCompletion = (Bool, String?) -> (Void)

public extension NamedObject where Self: NSManagedObject {
    
    public func nameChangeAlertController(in context: NSManagedObjectContext, with completion: @escaping NameChangeAlertCompletion) -> UIAlertController {
        var currentName: String?
        context.performAndWait {
            currentName = self.name
        }
        let alertController = UIAlertController(title: "Change Name", message: "Update object with a new name", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter name ..."
            textField.text = currentName
        }
        guard let textField = alertController.textFields?[0] else {
            fatalError()
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let actualName = textField.text {
                completion(true, actualName)
            } else {
                completion(false, nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            completion(false, nil)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        return alertController
    }
    
}
