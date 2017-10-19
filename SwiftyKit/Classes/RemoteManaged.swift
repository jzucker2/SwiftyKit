//
//  RemoteManaged.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/23/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import CoreData

public protocol Remote: Codable {
    static var service: String { get }
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
}

public protocol RemoteManaged: Remote {
    var uniqueIdentifier: String { get }
}

public extension Remote {
    public static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return .deferredToDate
    }
}

//protocol RemoteManaged {
//    var uniqueIdentifier: String { get }
//    static var service: String { get }
//}

// TODO: move this into CoreData submodule

public extension RemoteManaged where Self: NSManagedObject {
    
    
    
}
