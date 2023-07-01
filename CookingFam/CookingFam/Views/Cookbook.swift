//
//  Cookbook.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI


struct Cookbook: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<Recipe>
    
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    @Binding var cookbook: [Recipe]
    var body: some View {
        ZStack{
            BackgroundColor()
            
            if cookbook.isEmpty{
                Text("Add some recipes after cooking")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else{
                //displayes all recipes inside the cookbook
                List {
                    // Cards:
                    ForEach(cookbook.sorted(by: { $0.wrappedName < $1.wrappedName }), id: \.self){recipe in
                        RecipeCard(text: recipe.wrappedName, components: recipe.componentArray, selectedRecipe: recipe ,activeView: $activeView, activeRecipe: $activeRecipe)
                    }.listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                }
//            VStack{
//                Text("Nothing here yet. Comming in future updates")
//            }
        }
        
    }
}
