//
//  RecipeSearch.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI


struct RecipeSearch: View {
    @StateObject var recipesViewModel = RecipesViewModel()
    
    
    var body: some View {
        VStack{
            List{ ForEach(recipesViewModel.recipes, id: \.self){ recipe in
                Section(recipe.wrappedName){
                    ForEach(recipe.componentArray, id: \.self){ comp in
                        Text(comp.wrappedName)
                    }
                }
            }}
            HStack{
                Button("Add"){
                    recipesViewModel.addRecipe(name: "Bread with Butter", ingredients: [], directions: [], components: ["Bread", "Butter"])
                }
                Button("Delete"){
                    recipesViewModel.deleteEverything()
                }
            }
            
        }
        
    }
}
