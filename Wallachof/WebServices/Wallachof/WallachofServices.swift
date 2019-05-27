//
//  AuthService.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

protocol WallachofClient {
    func login(email: String, password: String,
               completion: @escaping (String?, Error?) -> () )

}

class WallachofClientImpl: APIClient, WallachofClient {

    let wallachofBaseURL = URL(string: "https://private-5980ce-wallachof.apiary-mock.com")!
    
    init() {        
        super.init(baseURL: wallachofBaseURL)
    }
    
    func login(email: String, password: String, completion: @escaping (String?, Error?) -> () ) {
        let signInResource = SignInResource(email: email, password: password)
        performRequest(resource: signInResource, completion: completion)
    }
}
