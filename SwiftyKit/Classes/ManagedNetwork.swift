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

//open class ManagedCodableRequest<T: >: CodableRequest {
//    override init(type: HTTPMethod = .GET, headers: [String : String]? = nil, body: Any? = nil, path: String? = nil, queryParameters: [String : String]? = nil) throws {
//        var finalHeaders = [String:String]()
//        if let providedHeaders = headers {
//            finalHeaders = providedHeaders
//        }
//        finalHeaders["Content-Type"] = "application/json"
//        var finalBody: Data?
//        if let actualBody = body {
//            switch actualBody {
//            case let actualData as Data:
//                finalBody = actualData
//            case let actualObject as T:
//                let encoder = JSONEncoder()
//                do {
//                    finalBody = try encoder.encode(actualObject)
//                } catch {
//                    throw NetworkError.invalidBody(actualObject)
//                }
//            default:
//                do {
//                    finalBody = try JSONSerialization.data(withJSONObject: actualBody, options: [.prettyPrinted])
//                } catch {
//                    throw NetworkError.invalidBody(actualBody)
//                }
//            }
//        }
//        try super.init(type: type, headers: finalHeaders, body: finalBody, path: T.service, queryParameters: queryParameters)
//    }
//}

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
