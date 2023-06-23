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
    
//    @StateObject private var multipeerManager = MultipeerManager()
    @State private var dataToSend = "Hello, World!"

    
    var body: some View {
        ZStack {
            BackgroundColor()
            VStack{
                //                Button("Reload"){
                //                    let dataController = DataController()
                //                    dataController.importCSV()
                //                }
                
                List {
                    // Cards:
                    ForEach(recipes, id: \.self){recipe in
                        RecipeCard(text: recipe.wrappedName, components: recipe.componentArray, selectedRecipe: recipe ,activeView: $activeView, activeRecipe: $activeRecipe)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            VStack {
                Button("Connect", action:  {activeView = .accept_view} )
                Spacer()
 
            }

            
        }
    }

}
