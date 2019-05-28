//
//  AuthService.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

class APIClient {
    
    let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func requestObject<T>(resource: Resource, completion: @escaping (RequestResult<T>) -> () ) {
        
        performRequest(resource: resource) { (httpResponse, data, error) in
            
            if let error = error {
                let apiError = APIClientError.other(error)
                completion(RequestResult.error(apiError))
                return
            }

            guard let statusCode = httpResponse?.statusCode else {
                let apiError = APIClientError.couldNotGetStatusCode
                completion(RequestResult.error(apiError))
                return
            }

            var jsonDict: JSONDictionary? = nil
            if let data = data {
                jsonDict = (try? JSONSerialization.jsonObject(with: data)) as? JSONDictionary
                if jsonDict == nil {
                    let apiError = APIClientError.couldNotDecodeJSON
                    completion(RequestResult.error(apiError))
                    return
                }
            }
            
            if 200..<300 ~= statusCode {
                if let jsonData = data {
                    let decoder = JSONDecoder()                    
                    do {
                        let objectDecoded = try decoder.decode(T.self, from: jsonData)
                        completion(RequestResult<T>.success(object: objectDecoded))
                    } catch {
                        let apiError = APIClientError.couldNotDecodeJSON
                        completion(RequestResult.error(apiError))
                    }
                }
                
            } else {
                let apiError = APIClientError.badStatus(status: statusCode, jsonError: jsonDict)
                completion(RequestResult.error(apiError))
            }
        }
        
    }
    
    func performRequest(resource: Resource,
               completion: @escaping (HTTPURLResponse?, Data?, Error?) -> () ) {
        
        let request = resource.requestWithBaseURL(baseURL: baseURL)
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                debugPrint("código es \(httpResponse.statusCode)")
                completion(httpResponse, data, nil)
            } else {
                print(error ?? "Unknown error")
                completion(nil, nil, error)
            }
        }
        
        task.resume()
        debugPrint("He lanzado la petición")
    }
    
}
