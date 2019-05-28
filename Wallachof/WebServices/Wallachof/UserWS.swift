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
    let color: UIColor
    let pet: Pet?
}

struct Pet: Codable {
    let name: String
    let isMale: Bool
    let numberOfLegs: Double
}

//extension UIColor: Encodable {
//
//
//}

// Codable: Decodable & Encodable
extension UserWS: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastname = "last_name"
        case email
        case color
        case pet
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(lastname, forKey: .lastname)
        try container.encode(email, forKey: .email)
        try container.encode(pet, forKey: .pet)
        
        let colorString = color.htmlRGBaColor
        try container.encode(colorString, forKey: .color)
    }

    static func testEncodable() {
        let lucas = Pet(name: "Lucas", isMale: false, numberOfLegs: 3.5)
        let david = UserWS(id: 30, name: "david", lastname: "jorge", email: "david@gmail.com", color: .red, pet: lucas)
        
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.lastname = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .name)
        self.pet = try container.decode(Pet.self, forKey: .pet)
        if let stringColor = try? container.decode(String.self, forKey: .color),
            let color = UIColor(hexaDecimalString: stringColor) {
            self.color = color
        } else {
            self.color = .clear
        }
        
    }
    
    static func testDecodable() {
        let jsonString = """
            {
                "id": 23,
                "name": "Andrea",
                "last_name": "Lasagna",
                "email": "lasagna@vegana.com",
                "color": "#00FF0030",
                "pet": {
                    "name": "Lola",
                    "isMale": false,
                    "numberOfLegs": 4,
                }
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

