//
//  UserWS.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

struct UserWS {
    let id: Int
    let name: String
    let lastName: String
    let email: String
}

extension UserWS: Codable {
    
    static func test() {
        let user = UserWS(id: 30, name: "david", lastName: "jorge", email: "david@gmail.com")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(user)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                debugPrint("Convertido \(jsonString)")
            }
        } catch {
            debugPrint("Error convirtiendo \(error.localizedDescription)")
        }
    }
    
}
