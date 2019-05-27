//
//  SignInResource.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct SignInResource: Resource {
    let method: Method = .post
    let endPoint = "user"
    let parameters: HTTPParameters = [:]
    let headers: HTTPParameters = [:]
    let boundary: String? = nil

    let bodyData: Data?

    init(email: String, password: String) {
        let json = ["email": email, "password": password]
        bodyData = try? JSONSerialization.data(withJSONObject: json, options: [])
    }
    
}
