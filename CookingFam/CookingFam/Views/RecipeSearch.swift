//
//  RecipeSearch.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI
import CoreData


struct RecipeSearch: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<Recipe>
    
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    
    var body: some View {
        ZStack {
            BackgroundColor()
            VStack{
//                Button("Reload"){
//                    let dataController = DataController()
//                    dataController.importCSV()
//                }
                
                Form {
                    // Cards:
                    ForEach(recipes, id: \.self){recipe in
                        RecipeCard(text: recipe.wrappedName, components: recipe.componentArray, selectedRecipe: recipe ,activeView: $activeView, activeRecipe: $activeRecipe)
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            VStack {
                Spacer()
                HStack {
                    
                    // QR-Scan:
                    Spacer()
                    HStack{
                        Image(systemName: "qrcode")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(10)
                        Text("Scan QU-Code")
                            .padding(10)
                    }
                    .background(Color(hex: 0xffd3b6))
                    .onTapGesture {
                        activeView = .qr
                    }
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                }
            }
        }
    }
}
