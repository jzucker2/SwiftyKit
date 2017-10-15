//
//  ManagedNetwork.swift
//  Pods
//
//  Created by Jordan Zucker on 10/15/17.
//

import Foundation

public protocol Remote: Codable {
//    var uniqueIdentifier: String { get }
    static var service: String { get }
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
}

public protocol RemoteManaged: Remote {
    var uniqueIdentifier: String { get }
}

extension Remote {
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy {
        return .deferredToDate
    }
}

open class CodableRequest<T: Remote>: JSONRequest {
    override init(type: HTTPMethod = .GET, headers: [String : String]? = nil, body: Any? = nil, path: String? = nil, queryParameters: [String : String]? = nil) throws {
        var finalHeaders = [String:String]()
        if let providedHeaders = headers {
            finalHeaders = providedHeaders
        }
        finalHeaders["Content-Type"] = "application/json"
        var finalBody: Data?
        if let actualBody = body {
            switch actualBody {
            case let actualData as Data:
                finalBody = actualData
            case let actualObject as T:
                let encoder = JSONEncoder()
                do {
                    finalBody = try encoder.encode(actualObject)
                } catch {
                    throw NetworkError.invalidBody(actualObject)
                }
            default:
                do {
                    finalBody = try JSONSerialization.data(withJSONObject: actualBody, options: [.prettyPrinted])
                } catch {
                    throw NetworkError.invalidBody(actualBody)
                }
            }
        }
        try super.init(type: type, headers: finalHeaders, body: finalBody, path: T.service, queryParameters: queryParameters)
    }
}

open class ManagedCodableRequest<U: RemoteManaged>: CodableRequest<U> {
    public required init(type: HTTPMethod = .GET, object: U, body: Any? = nil, headers: [String : String]? = nil, queryParameters: [String : String]? = nil) throws {
        var finalPath: String
        switch type {
        case .GET, .PATCH, .PUT, .DELETE:
            finalPath = "\(U.service)/\(object.uniqueIdentifier)"
        case .POST:
            finalPath = "\(U.service)"
        }
        try super.init(type: type, headers: headers, body: body, path: finalPath, queryParameters: queryParameters)
    }
}

extension Network {
    
    public func executeCodableTask<T>(with request: CodableRequest<T>, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
        try executeDataTask(with: request, and: { (response, data, error) -> (Void) in
            guard let actualData = data else {
                completion(response, nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = T.dateDecodingStrategy
                let finalObject: T? = try decoder.decode(T.self, from: actualData)
                completion(response, finalObject, error)
                return
            } catch {
                print("decoder error: \(error.localizedDescription)")
                let result = try! JSONSerialization.jsonObject(with: actualData, options: [.allowFragments])
                print("Result::::=======>: \(result)")
                completion(response, nil, NetworkError.JSONSerializationError(error))
            }
        })
    }
    
}

extension Network {
    public func GET<T: Remote>(_ object: T, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
        let request = try CodableRequest<T>(type: .GET)
        try executeCodableTask(with: request, and: completion)
    }
    public func POST<T: Remote>(_ object: T, body: Any? = nil, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
        let request = try CodableRequest<T>(type: .POST, body: body)
        try executeCodableTask(with: request, and: completion)
    }
    public func PATCH<T: Remote>(_ object: T, body: Any? = nil, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
        let request = try CodableRequest<T>(type: .PATCH, body: body)
        try executeCodableTask(with: request, and: completion)
    }
}


extension Network {
    
    public func GET<U: RemoteManaged>(_ object: U, and completion: @escaping (HTTPURLResponse?, U?, Error?) -> (Void)) throws {
        let request = try ManagedCodableRequest<U>(type: .GET, object: object)
        try executeCodableTask(with: request, and: completion)
    }
    public func POST<U: RemoteManaged>(_ object: U, body: Any? = nil, and completion: @escaping (HTTPURLResponse?, U?, Error?) -> (Void)) throws {
        let request = try ManagedCodableRequest<U>(type: .POST, object: object, body: body)
        try executeCodableTask(with: request, and: completion)
    }
    public func PATCH<U: RemoteManaged>(_ object: U, body: Any? = nil, and completion: @escaping (HTTPURLResponse?, U?, Error?) -> (Void)) throws {
        let request = try ManagedCodableRequest<U>(type: .PATCH, object: object, body: body)
        try executeCodableTask(with: request, and: completion)
    }
    
//    public func GET<U: RemoteManaged>(object: U, combining queryParameters: [String: String]? = nil, and completion: @escaping (HTTPURLResponse?, U?, Error?) -> (Void)) throws {
//        let request = try ManagedCodableRequest(type: .GET, object: , queryParameters: queryParameters)
//
//    }
//
//    public func POST<T>(sending body: Any? = nil, combining queryParameters: [String: String]? = nil, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
//
//    }
//
//    public func PATCH<T>(sending body: Any? = nil, combining queryParameters: [String: String]? = nil, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
//
//    }
    
}
