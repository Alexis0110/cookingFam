//
//  Cookbook+CoreDataProperties.swift
//  CookingFam
//
//  Created by Alexis on 30.06.23.
//
//

import Foundation
import CoreData


extension Cookbook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cookbook> {
        return NSFetchRequest<Cookbook>(entityName: "Cookbook")
    }

    @NSManaged public var name: String?
    @NSManaged public var recipe: NSSet?
    
    public var wrappedName: String{
        name ?? "Unknown cookbook"
    }
    
    public var recipeArray: [Recipe]{
        let set = recipe as? Set<Recipe> ?? []
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for recipe
extension Cookbook {

    @objc(addRecipeObject:)
    @NSManaged public func addToRecipe(_ value: Recipe)

    @objc(removeRecipeObject:)
    @NSManaged public func removeFromRecipe(_ value: Recipe)

    @objc(addRecipe:)
    @NSManaged public func addToRecipe(_ values: NSSet)

    @objc(removeRecipe:)
    @NSManaged public func removeFromRecipe(_ values: NSSet)

}

extension Cookbook : Identifiable {

}
