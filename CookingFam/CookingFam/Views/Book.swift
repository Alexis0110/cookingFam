//
//  Cookbook.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI


struct Book: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cbook: FetchedResults<Cookbook>
    
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    var body: some View {
        ZStack{
            BackgroundColor()
            
            VStack{
                if cbook[0].recipeArray.isEmpty{
                    Text("Add some recipes after cooking")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else{
                    //displayes all recipes inside the cookbook
                    List {
                        // Cards:
                        ForEach(cbook[0].recipeArray, id: \.self){recipe in
                            RecipeCard(text: recipe.wrappedName, components: recipe.componentArray, selectedRecipe: recipe ,activeView: $activeView, activeRecipe: $activeRecipe)
                        }.onDelete(perform: delete)
                        .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            
                    }
                    .listStyle(PlainListStyle())
                    }
            }
        }
    }
    func delete(at offsets: IndexSet){
        for offset in offsets{
            let recipe = cbook[0].recipeArray[offset]
            moc.delete(recipe)
        }
        try? moc.save()
    }
}
