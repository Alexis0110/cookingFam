//
//  Persistence.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

//struct Model {
//
//}
import UIKit
import CoreData

// MARK: - Core Data Stack

class CoreData {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Recipes") // Replace with your actual data model name
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print("Error setting up Core Data: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}

// MARK: - Data Model

class Recipe: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var number: Int16
}




