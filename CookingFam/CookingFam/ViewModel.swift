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
    private var dataController = DataController(name: "Model")
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
    
    func addData(name :  String){
        let newRecipe = Recipe(context: dataController.container.viewContext)
        newRecipe.id = UUID()
        newRecipe.name = name
        
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
