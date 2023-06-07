//
//  Component+CoreDataProperties.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//
//

import Foundation
import CoreData


extension Component {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Component> {
        return NSFetchRequest<Component>(entityName: "Component")
    }

    @NSManaged public var name: String?
    @NSManaged public var recipe: Recipe?

    public var wrappedName: String{
        name ?? "Unknown component"
    }
}

extension Component : Identifiable {

}
