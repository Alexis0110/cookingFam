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
    @Environment(\.managedObjectContext) var moc
    private var dataController = DataController()
    
//    init(){
//    }
    
    func reloadData(){
//        deleteAll()
        
//        let firstName = "No-Bake Nut Cookies"
//        let firstIngredients = ["1 c. firmly packed brown sugar", "1/2 c. evaporated milk", "1/2 tsp. vanilla", "1/2 c. broken nuts (pecans)", "2 Tbsp. butter or margarine", "3 1/2 c. bite size shredded rice biscuits"]
//        let firstDirections = ["In a heavy 2-quart saucepan, mix brown sugar, nuts, evaporated milk and butter or margarine.", "Stir over medium heat until mixture bubbles all over top.", "Boil and stir 5 minutes more. Take off heat.", "Stir in vanilla and cereal; mix well.", "Using 2 teaspoons, drop and shape into 30 clusters on wax paper.", "Let stand until firm, about 30 minutes."]
//        let firstComponents = ["brown sugar", "milk", "vanilla", "nuts", "butter", "bite size shredded rice biscuits"]
//
//        firstIngredients.forEach {ingredient in
//            let ingr = Ingredient(context: moc)
//            ingr.name = ingredient
//            ingr.recipe = Recipe(context: moc)
//            ingr.recipe?.name = firstName
//
//            save()
//        }
//
//        firstDirections.forEach {direction in
//            let dir = Ingredient(context: moc)
//            dir.name = direction
//            dir.recipe = Recipe(context: moc)
//            dir.recipe?.name = firstName
//
//            save()
//        }
//
//        firstComponents.forEach {component in
//            let comp = Ingredient(context: moc)
//            comp.name = component
//            comp.recipe = Recipe(context: moc)
//            comp.recipe?.name = firstName
//
//            save()
//        }
        
//        let component = Component(context: moc)
//        component.name = "Bread"
//        component.recipe = Recipe(context: moc)
//        component.recipe?.name = "Bread and Apple"
//        
//        let component1 = Component(context: moc)
//        component1.name = "Apple"
//        component1.recipe = Recipe(context: moc)
//        component1.recipe?.name = "Schmead"
//        
//        try? moc.save()
    }
    
//    func del() {
//        dataController.deleteAll()
//    }
   
    
    func save(){
        try? moc.save()
    }
}

extension ContentView {
    @MainActor class ViewModel:ObservableObject{
    }
}
