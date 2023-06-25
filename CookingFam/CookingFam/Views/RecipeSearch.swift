//
//  RecipeSearch.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI
import CoreData
import MultipeerConnectivity

struct RecipeSearch: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<Recipe>
    
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    @State private var newSearch: String  = ""
    @State private var shownRecipes: [Recipe] = []
    
    var body: some View {
        ZStack {
            BackgroundColor()
            VStack{
                TextField("Search", text: $newSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                // TODO: make search icon!!
                Button("search") {
                    var temp: [Recipe] = []
                    for recipe in recipes {
                        if newSearch == ""{
                            // reset list
                            temp.append(recipe)
                        }else{
                            // look for name
                            if recipe.wrappedName.containsSubstringRegex(newSearch){
                                temp.append(recipe)
                            }
                            // look for ingredient
                            if recipe.ingredientArray.contains(where: { $0.wrappedName.containsSubstringRegex(newSearch) }){
                                if !temp.contains(recipe){
                                    temp.append(recipe)
                                }
                            }
                            // look for Direction
                            if recipe.directionArray.contains(where: { ($0.text ?? "Error").containsSubstringRegex(newSearch) }){
                                if !temp.contains(recipe){
                                    temp.append(recipe)
                                }
                            }
                        }
                    }
                    shownRecipes = temp
                    hideKeyboard()
                }
                .padding()
                List {
                    // Cards:
                    ForEach(shownRecipes.sorted(by: { $0.wrappedName < $1.wrappedName }), id: \.self){recipe in
                        RecipeCard(text: recipe.wrappedName, components: recipe.componentArray, selectedRecipe: recipe ,activeView: $activeView, activeRecipe: $activeRecipe)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            VStack{
                    
            }
            VStack {
                Button("Connect", action:  {activeView = .accept_view} )
                Spacer()
            }
        }.onAppear(){
            for a in recipes {
                shownRecipes.append(a)
            }
        }
    }
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}
