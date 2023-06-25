//
//  RecipeDetails.swift
//  CookingFam
//
//  Created by Alexis on 08.06.23.
//

import Foundation
import SwiftUI

struct RecipeDetails: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<Recipe>
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    @Binding var dividedDirections : [String:[String]]
    
    
    var body: some View {
        ZStack {
            BackgroundColor()
            
            VStack(spacing: 16) {
                HStack {
                    BackButton(activeView: $activeView, prevView: .search)
                        .padding(.leading, 16)
                    
                    Spacer()
                }
                
                Image(systemName: "takeoutbag.and.cup.and.straw")
                    .font(.system(size: 100))
                    .foregroundColor(Color(hex: 0xffaaa5))
                
                VStack(spacing: 8) {
                    Text(activeRecipe.wrappedName)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ForEach(activeRecipe.ingredientArray, id: \.self) { ingredient in
                        Text(ingredient.wrappedName)
                            .font(.body)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                HStack{
                    Text("Cook with others")
                        .padding(10)
                }.onTapGesture {
                    activeView = .addCooks
                }
                .background(Color(hex: 0xffd3b6))
                .cornerRadius(10)
                .padding()
                .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3)
                HStack{
//                    Image(systemName: "Plus")
                    Text("Cook alone")
                        .padding(10)
                }.onTapGesture {
                    var directionStrings : [String] = []
                    for direction in activeRecipe.directionArray{
                        directionStrings.append(direction.wrappedText)
                    }
                    dividedDirections["Cooking"] = directionStrings
                    activeView = .cooking
                }
            }
            .padding()
                
        }
    }
    
    //TODO: remove falls nich mehr nötig
    private var backButton: some View {
        Button(action: {
            // Handle the "Go Back" action here
            activeView = .search
        }) {
            Image(systemName: "chevron.left")
                .font(.title2)
        }
        .foregroundColor(Color(hex: 0xff8b94))
    }
}
