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
    @FetchRequest(sortDescriptors: [], predicate: nil)
    var recipes: FetchedResults<Recipe>
    
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    @State private var newSearch: String  = ""
    @State private var shownRecipes: [Recipe] = []
    
    var body: some View {
        ZStack {
            BackgroundColor()
            VStack{
            HStack{
                TextField("Search", text: $newSearch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accentColor(Color("Color5"))
                //filter recipes according to the parameters entered in the TextField
                Button(action:  {
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
                }){
                    Image(systemName: "magnifyingglass")
                }
            }
            .padding()
                if shownRecipes.isEmpty{
                    Text("No Recipes with these serchparameters")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else{
                    //displays ll recipes with matching searchparameters
                    List {
                        ForEach(shownRecipes.sorted(by: { $0.wrappedName < $1.wrappedName }), id: \.self){recipe in
                            RecipeCard(text: recipe.wrappedName, components: recipe.componentArray, selectedRecipe: recipe ,activeView: $activeView, activeRecipe: $activeRecipe)
                        }.listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                    }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HStack{
                        Text("Cook with others")
                            .padding(10)
                            .foregroundColor(Color("Text"))
                    }.onTapGesture {
                        activeRecipe = shownRecipes[0]
                        activeView = .accept_view
                    }
                    .background(Color("Color3"))
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16))
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                }
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
