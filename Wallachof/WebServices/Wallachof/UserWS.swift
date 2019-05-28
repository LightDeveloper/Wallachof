//
//  UserWS.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
import UIKit

struct UserWS {
    let id: Int
    let name: String
    let lastname: String
    let email: String
    let pet: Pet?
//    let color: UIColor
}

struct Pet: Codable {
    let name: String
    let isMale: Bool
    let numberOfLegs: Double
}

// Codable: Decodable & Encodable
extension UserWS: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastname = "last_name"
        case email
        case pet
    }
    
//    init(from decoder: Decoder) throws {
//
//
//    }
    
    
    static func testEncodable() {
        let lucas = Pet(name: "Lucas", isMale: false, numberOfLegs: 3.5)
        let david = UserWS(id: 30, name: "david", lastname: "jorge", email: "david@gmail.com", pet: lucas)
        
        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(david)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                debugPrint("Convertido \(jsonString)")
            }
        } catch {
            debugPrint("Error convirtiendo \(error.localizedDescription)")
        }
    }
}

extension UserWS: Decodable {
    
    static func testDecodable() {
        let jsonString = """
            {
                "id": 23,
                "name": "Andrea",
                "last_name": "Lasagna",
                "email": "lasagna@vegana.com",
                "pet": null
            }
"""
        let jsonData = jsonString.data(using: .utf8)
        let decoder = JSONDecoder()
        do {
            let user = try decoder.decode(UserWS.self, from: jsonData!)
            debugPrint("User \(user)")
        } catch let error {
            debugPrint("😤 ha fallao, cagüen to \(error)")
        }
        
    }
    
}

