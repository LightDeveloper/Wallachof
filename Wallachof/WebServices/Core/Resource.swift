//
//  Resource.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

typealias HTTPParameterKey = String
typealias HTTPParameterValue = String
typealias HTTPParameters = [HTTPParameterKey: HTTPParameterValue]

enum Method: String {
    case get
    case post
    case delete
    case put
    case patch
}

protocol Resource {
    var method: Method { get }
    var endPoint: String { get }
    var parameters: HTTPParameters { get }
    var headers: HTTPParameters { get }
    var bodyData: Data? { get }
    var boundary: String? { get }
}

extension Resource {
    
    func requestWithBaseURL(baseURL: URL) -> URLRequest {
        let urlPath = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: urlPath)
        request.httpMethod = method.rawValue.uppercased()
        
        for (header, value) in headers {
            request.setValue(value, forHTTPHeaderField: header)
        }
        
        if let boundary = boundary {
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }
        
        if !parameters.isEmpty {
            guard var components = URLComponents(url: urlPath, resolvingAgainstBaseURL: false) else {
                fatalError("No he podido crear los componentes :)")
            }
            
            components.queryItems = parameters.map({ (key: String, value: String ) -> URLQueryItem in
                return URLQueryItem(name: key, value: value)
            })
            
            guard let finalURL = components.url else {
                fatalError("No he podido crear la url final")
            }
            
            request.url = finalURL
        }
        
        if let bodyData = bodyData {
            request.httpBody = bodyData
        }
        
        return request
    }
    
}
