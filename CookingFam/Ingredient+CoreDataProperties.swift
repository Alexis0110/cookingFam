//
//  Ingredient+CoreDataProperties.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var amount: Double
    @NSManaged public var name: String?
    @NSManaged public var recipe: Recipe?

}

extension Ingredient : Identifiable {

}
