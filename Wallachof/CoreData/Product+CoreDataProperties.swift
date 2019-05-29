//
//  Product+CoreDataProperties.swift
//  Wallachof
//
//  Created by Dev2 on 29/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var publicDate: NSDate?
    @NSManaged public var sold: Bool
    @NSManaged public var thumb: NSData?
    @NSManaged public var user: User?

}
