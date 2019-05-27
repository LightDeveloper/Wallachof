//
//  AuthService.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

protocol AuthService {
    func login(email: String, password: String,
               completion: @escaping (String?, Error?) -> () )

}

class AuthServiceImpl: AuthService {

    let url = URL(string: "https://private-5980ce-wallachof.apiary-mock.com/user-fail")!

    func login(email: String, password: String,
               completion: @escaping (String?, Error?) -> () ) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            debugPrint("Tengo respuesta de la petición")

            if let response = response as? HTTPURLResponse {
                debugPrint("código es \(response.statusCode)")
                
                if let data = data, let body = String(data: data, encoding: .utf8) {
                    print(body)
                    completion(body, nil)
                }
            } else {
                print(error ?? "Unknown error")
                completion(nil, error)
            }
        }
        
        task.resume()
        debugPrint("He lanzado la petición")
    }
    
}
