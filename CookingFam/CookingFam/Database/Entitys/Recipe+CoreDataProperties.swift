//
//  Recipe+CoreDataProperties.swift
//  CookingFam
//
//  Created by Alexis on 01.07.23.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var component: NSSet?
    @NSManaged public var cookbook: Cookbook?
    @NSManaged public var direction: NSSet?
    @NSManaged public var ingredient: NSSet?
    
    public var wrappedId: UUID{
        id!
    }
    
    public var wrappedName: String{
        name ?? "Unknown recipe"
    }
    
    public var ingredientArray: [Ingredient]{
        let set = ingredient as? Set<Ingredient> ?? []
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var directionArray: [Direction]{
        let set = direction as? Set<Direction> ?? []
        return set.sorted{
            $0.wrappedText < $1.wrappedText
        }
    }
    
    public var componentArray: [Component]{
        let set = component as? Set<Component> ?? []
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for component
extension Recipe {

    @objc(addComponentObject:)
    @NSManaged public func addToComponent(_ value: Component)

    @objc(removeComponentObject:)
    @NSManaged public func removeFromComponent(_ value: Component)

    @objc(addComponent:)
    @NSManaged public func addToComponent(_ values: NSSet)

    @objc(removeComponent:)
    @NSManaged public func removeFromComponent(_ values: NSSet)

}

// MARK: Generated accessors for direction
extension Recipe {

    @objc(addDirectionObject:)
    @NSManaged public func addToDirection(_ value: Direction)

    @objc(removeDirectionObject:)
    @NSManaged public func removeFromDirection(_ value: Direction)

    @objc(addDirection:)
    @NSManaged public func addToDirection(_ values: NSSet)

    @objc(removeDirection:)
    @NSManaged public func removeFromDirection(_ values: NSSet)

}

// MARK: Generated accessors for ingredient
extension Recipe {

    @objc(addIngredientObject:)
    @NSManaged public func addToIngredient(_ value: Ingredient)

    @objc(removeIngredientObject:)
    @NSManaged public func removeFromIngredient(_ value: Ingredient)

    @objc(addIngredient:)
    @NSManaged public func addToIngredient(_ values: NSSet)

    @objc(removeIngredient:)
    @NSManaged public func removeFromIngredient(_ values: NSSet)

}

extension Recipe : Identifiable {

}
