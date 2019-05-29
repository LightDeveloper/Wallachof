//
//  Product+CoreDataClass.swift
//  Wallachof
//
//  Created by Dev2 on 20/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {

    static var all: [Product] {
        
        let productosRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        do {
            let productos = try context.fetch(productosRequest)
            return productos
        } catch {
            debugPrint("Error al hacer un fetch request grave no, gravisísísísmo")
            return []
        }

    }    
}
