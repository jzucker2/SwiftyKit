//
//  Network.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/9/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case PATCH = "PATCH"
}

typealias DataNetworkResponseBlock = (HTTPURLResponse?, Data?, Error?) -> (Void)
typealias JSONNetworkResponseBlock = (HTTPURLResponse?, Any?, Error?) -> (Void)

protocol Network: class {
    
    var operationQueue: OperationQueue { get }
    
    var host: String { get }
    var session: URLSession { get }
    func request(with path: String, and queryParameters: [String:String]?) -> URLRequest
    func executeDataTask(of type: HTTPMethod, including headers: [String: String]?, sending body: Data?, with path: String, combining queryParameters: [String:String]?, and completion: @escaping DataNetworkResponseBlock) throws
    func executeJSONTask(of type: HTTPMethod, including headers: [String: String]?, sending body: Any?, with path: String, combining queryParameters: [String:String]?, and completion: @escaping JSONNetworkResponseBlock) throws
}

enum NetworkError: PromptError {
    case invalidBody(Any)
    case invalidURLResponse(URLResponse?)
    case JSONSerializationError(Error)
    case unknown(String?)
    
    var prompt: String {
        switch self {
        case .invalidBody(_):
            return "Body does not convert to data"
        case let .invalidURLResponse(response):
            let responseMessage = response.debugDescription
            return "Response is not HTTP, it is: \(responseMessage)"
        case let .JSONSerializationError(error):
            return "JSONSerialization from response data into JSON went wrong: \(error.localizedDescription)"
        case let .unknown(message):
            let relatedMessage = message ?? "Unknown!"
            return "Unknown error, maybe related to \(relatedMessage)"
        }
    }
}

extension Network {
    
    func executeDataTask(of type: HTTPMethod = .GET, including headers: [String: String]? = nil, sending body: Data? = nil, with path: String, combining queryParameters: [String:String]? = nil, and completion: @escaping DataNetworkResponseBlock) throws {
        var taskRequest = request(with: path, and: queryParameters)
        taskRequest.allHTTPHeaderFields = headers
        taskRequest.httpMethod = type.rawValue
        taskRequest.httpBody = body
        session.dataTask(with: taskRequest) { (receivedData, receivedResponse, receivedError) in
            if let actualError = receivedError {
                completion(nil, nil, actualError)
                return
            }
            guard let httpResponse = receivedResponse as? HTTPURLResponse else {
                completion(nil, nil, NetworkError.invalidURLResponse(receivedResponse))
                return
            }
            completion(httpResponse, receivedData, nil)
        }.resume()
    }
    
}

extension Network {
    
    func executeJSONTask(of type: HTTPMethod = .GET, including headers: [String: String]? = ["Content-Type": "application/json"], sending body: Any? = nil, with path: String, combining queryParameters: [String:String]? = nil, and completion: @escaping JSONNetworkResponseBlock) throws {
        var finalBodyData: Data?
        if let actualBody = body {
            do {
                finalBodyData = try JSONSerialization.data(withJSONObject: actualBody, options: .prettyPrinted)
            } catch {
                throw NetworkError.invalidBody(actualBody)
            }
        }
        try executeDataTask(of: type, including: headers, sending: finalBodyData, with: path, combining: queryParameters, and: { (receivedResponse, receivedData, receivedError) -> (Void) in
            if let actualError = receivedError {
                completion(nil, nil, actualError)
                return
            }
            var finalJSON: Any?
            if let actualData = receivedData {
                do {
                    finalJSON = try JSONSerialization.jsonObject(with: actualData, options: [.allowFragments])
                } catch {
                    completion(receivedResponse, nil, NetworkError.JSONSerializationError(error))
                }
            }
            completion(receivedResponse, finalJSON, nil)
        })
    }
    
}

//extension Network {
//    
//    func executeCodableTask<T: RemoteManaged & Codable>(of requestType: HTTPMethod = .GET, including headers: [String: String]? = ["Content-Type": "application/json"], sending body: Any? = nil, with path: String = T.service, combining queryParameters: [String:String]? = nil, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
////        var finalBodyData: Data?
////        if let actualBody = body {
////            do {
////                let encoder = JSONEncoder()
//////                let decoder = JSONDecoder()
////                finalBodyData = try encoder.encode(actualBody)
//////                finalBodyData = try decoder.decode(actualBody.self, from: actualBody)
////
//////                finalBodyData = try JSONSerialization.data(withJSONObject: actualBody, options: .prettyPrinted)
////            } catch {
////                fatalError(error.localizedDescription)
//////                throw NetworkError.invalidBody(actualBody)
////            }
////        }
//        var finalBodyData: Data?
//        if let actualBody = body {
//            do {
//                finalBodyData = try JSONSerialization.data(withJSONObject: actualBody, options: .prettyPrinted)
//            } catch {
//                throw NetworkError.invalidBody(actualBody)
//            }
//        }
//        try executeDataTask(of: requestType, including: headers, sending: finalBodyData, with: path, combining: queryParameters, and: { (receivedResponse, receivedData, receivedError) -> (Void) in
//            if let actualError = receivedError {
//                completion(nil, nil, actualError)
//                return
//            }
////            var finalJSON: Any?
//            if let actualData = receivedData {
//                do {
//                    let finalJSON = try JSONSerialization.jsonObject(with: actualData, options: [.allowFragments])
//                    print("finalJSON: ", finalJSON)
//                } catch {
//                    fatalError(error.localizedDescription)
////                    completion(receivedResponse, nil, NetworkError.JSONSerializationError(error))
//                }
//            }
//            var finalObject: T?
//            guard let actualData = receivedData else {
//                completion(receivedResponse, nil, nil)
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                // TODO: Clean up decoder with date handling
//                decoder.dateDecodingStrategy = .millisecondsSince1970
////                decoder.dateDecodingStrategy = .custom({ (thisDecoder) -> Date in
////                    thisDecoder.
////                    return Date()
////                })
//                finalObject = try decoder.decode(T.self, from: actualData)
//                completion(receivedResponse, finalObject, nil)
//            } catch {
//                print("decoder error: \(error.localizedDescription)")
//                let result = try! JSONSerialization.jsonObject(with: actualData, options: [.allowFragments])
//                print("Result::::=======>: \(result)")
//                completion(receivedResponse, nil, NetworkError.JSONSerializationError(error))
//            }
//        })
//    }
//    
//}

extension Network {
    
    func request(with path: String, and queryParameters: [String:String]? = nil) -> URLRequest {
        guard let actualURL = URL(string: "\(host)/\(path)/") else {
            fatalError()
        }
        guard var components = URLComponents(url: actualURL, resolvingAgainstBaseURL: false) else {
            fatalError()
        }
        if let actualQueryParams = queryParameters {
            let queryItems = actualQueryParams.map({ (key, value) -> URLQueryItem in
                return URLQueryItem(name: key, value: value)
            })
            components.queryItems = queryItems
        }
        guard let finalURL = components.url else {
            fatalError()
        }
        return URLRequest(url: finalURL)
    }
    
}

//extension Network {
//
//    func GET<T: RemoteManaged & Codable>(with identifier: String, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
//        var finalPath: String
//        if identifier == "" {
//            finalPath = T.service
//        } else {
//            finalPath = "\(T.service)/\(identifier)"
//        }
//        try executeCodableTask(with: finalPath, and: completion)
//    }
//
//    func PATCH<T: RemoteManaged & Codable>(with identifier: String, sending body: Any? = nil, combining queryParameters: [String: String]? = nil, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
//        var finalPath: String
//        if identifier == "" {
//            finalPath = T.service
//        } else {
//            finalPath = "\(T.service)/\(identifier)"
//        }
//        try executeCodableTask(of: .PATCH, sending: body, with: finalPath, combining: queryParameters, and: completion)
//    }
//
//    func POST<T: RemoteManaged & Codable>(including headers: [String: String]? = ["Content-Type": "application/json"], sending body: Any?, and completion: @escaping (HTTPURLResponse?, T?, Error?) -> (Void)) throws {
////        try executeCodableTask(of: .POST, sending: body, with: T.service, and: completion)
//        try executeCodableTask(of: .POST, including: headers, sending: body, with: T.service, and: completion)
//    }
//
//}

