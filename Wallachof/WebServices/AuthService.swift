//
//  AuthService.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

protocol AuthService {
    func login(email: String, password: String)
}

class AuthServiceImpl: AuthService {

    let url = URL(string: "https://private-5980ce-wallachof.apiary-mock.com/tests")!

    func login(email: String, password: String) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                debugPrint(response)
                
                if let data = data, let body = String(data: data, encoding: .utf8) {
                    print(body)
                }
            } else {
                print(error ?? "Unknown error")
            }
        }
        
        task.resume()
    }
    
}
