//
//  ViewModel.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import Foundation
import SwiftUI
import LocalAuthentication
import CoreData


class RecipesViewModel: ObservableObject{
    private var dataController = DataController()
//    @Environment(\.managedObjectContext) var moc
    @Published var recipes = [Recipe]()
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        do{
            recipes = try
            dataController.container.viewContext.fetch(request)
        }catch{
            print("Error CoreData")
        }
    }
 
    
    func addRecipe(name : String, ingredients : [String], directions : [String], components : [String] ){
        let newRecipe = Recipe(context: dataController.container.viewContext)
        newRecipe.id = UUID()
        newRecipe.name = name
        //ingredients
        //directions
        //components
//        var componentSet = NSSet(array: components)
//        newRecipe.component = componentSet
//        newRecipe.component = Component(context: dataController.container.viewContext)
//        newRecipe.component?.name = components[0]
        save()
        fetchData()
    }
    
    func deleteEverything(){
        dataController.deleteAll()
        save()
        fetchData()
    }
    
    func deleteItem(at offsets : IndexSet){
        for offset in offsets {
            let recipe = recipes[offset]
            dataController.container.viewContext.delete(recipe)
        }
        save()
        fetchData()
    }
    
    func save(){
        try? dataController.container.viewContext.save()
    }
}

extension ContentView {
    @MainActor class ViewModel:ObservableObject{
    }
}
