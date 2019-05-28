//
//  APIClientError.swift
//  Wallachof
//
//  Created by Dev2 on 28/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

enum APIClientError: Error {
    case malformedURL(url: String)
    case couldNotGetStatusCode
    case couldNotDecodeJSON
    case badStatus(status: Int, jsonError: JSONDictionary?)
    case other(Error)
}

extension APIClientError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case let .malformedURL(url):
            return "malformed URL \(url)"
        case .couldNotGetStatusCode:
            return "Could not get status code"
        case .couldNotDecodeJSON:
            return "Could not decode JSON"
        case let .badStatus(status):
            return "Bad status \(status)"
        case let .other(error):
            return "\(error)"
        }
    }
}

