//
//  Network.swift
//  PomodoroTurntableApp
//
//  Created by Jordan Zucker on 7/9/17.
//  Copyright © 2017 Stanera. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

public typealias DataNetworkResponseBlock = (HTTPURLResponse?, Data?, Error?) -> (Void)
public typealias JSONNetworkResponseBlock = (HTTPURLResponse?, Any?, Error?) -> (Void)

public protocol Network: class {
    
    var operationQueue: OperationQueue { get }
    
    var host: String { get }
    var session: URLSession { get }
    func generateURLRequest(with path: String?, and queryParameters: [String : String]?) -> URLRequest
    func executeDataTask(with request: Request, and completion: @escaping DataNetworkResponseBlock) throws
    func executeJSONTask(with request: JSONRequest, and completion: @escaping JSONNetworkResponseBlock) throws
}

public enum NetworkError: PromptError {
    case invalidBody(Any)
    case invalidURLResponse(URLResponse?)
    case JSONSerializationError(Error)
    case unknown(String?)
    
    public var prompt: String {
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

open class Request {
    let type: HTTPMethod
    let headers: [String:String]?
    let body: Data?
    let path: String?
    let queryParameters: [String:String]?
    
    public init(type: HTTPMethod = .GET, headers: [String:String]? = nil, body: Any? = nil, path: String? = nil, queryParameters: [String:String]? = nil) throws {
        var finalBody: Data?
        if let actualBody = body {
            guard let convertedBody = actualBody as? Data else {
                throw NetworkError.invalidBody("Can only handle Data")
            }
            finalBody = convertedBody
        }
        self.type = type
        self.headers = headers
        self.body = finalBody
        self.path = path
        self.queryParameters = queryParameters
    }
    
}

open class JSONRequest: Request {
    
    public override init(type: HTTPMethod = .GET, headers: [String : String]? = nil, body: Any? = nil, path: String? = nil, queryParameters: [String : String]? = nil) throws {
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
            default:
                do {
                    finalBody = try JSONSerialization.data(withJSONObject: actualBody, options: [.prettyPrinted])
                } catch {
                    throw NetworkError.invalidBody(actualBody)
                }
            }
        }
        try super.init(type: type, headers: finalHeaders, body: finalBody, path: path, queryParameters: queryParameters)
    }
    
}

extension Network {
    
    public func executeDataTask(with request: Request, and completion: @escaping DataNetworkResponseBlock) throws {
        var taskRequest = generateURLRequest(with: request.path, and: request.queryParameters)
        taskRequest.allHTTPHeaderFields = request.headers
        taskRequest.httpMethod = request.type.rawValue
        taskRequest.httpBody = request.body
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
    
    public func executeJSONTask(with request: JSONRequest, and completion: @escaping JSONNetworkResponseBlock) throws {
        try executeDataTask(with: request, and: { (receivedResponse, receivedData, receivedError) -> (Void) in
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

extension Network {
    
    public func generateURLRequest(with path: String? = nil, and queryParameters: [String:String]? = nil) -> URLRequest {
        var finalPath = host
        if let actualPath = path {
            finalPath = "\(host)/\(actualPath)"
        }
        guard let actualURL = URL(string: finalPath) else {
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
