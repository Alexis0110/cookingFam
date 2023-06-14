//
//  Direction+CoreDataProperties.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//
//

import Foundation
import CoreData


extension Direction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Direction> {
        return NSFetchRequest<Direction>(entityName: "Direction")
    }

    @NSManaged public var text: String?
    @NSManaged public var recipe: Recipe?

}

extension Direction : Identifiable {

}
