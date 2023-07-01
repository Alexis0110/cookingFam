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
            BackButton(activeView: $activeView, prevView: .search)
            
            //dislay the clicked recipe
            VStack(spacing: 16) {
                Image(systemName: "takeoutbag.and.cup.and.straw")
                    .font(.system(size: 100))
                    .foregroundColor(Color(hex: 0xffaaa5))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(activeRecipe.wrappedName)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Text"))
                    
                    ForEach(activeRecipe.ingredientArray, id: \.self) { ingredient in
                        Text(ingredient.wrappedName)
                            .font(.body)
                            .foregroundColor(Color("Text"))
                    }
                }
                .padding()
                .background(Color("Background"))
                .cornerRadius(10)
                .shadow(color: Color.gray.opacity(0.3), radius: 2, x: 0, y: 2)
                
                Button(action: {
                    activeView = .addCooks
                }) {
                    ButtonText(text: "Cook with others", disabled: false)
                        
                }
                
                Button(action: {
                    var directionStrings: [String] = []
                    for direction in activeRecipe.directionArray {
                        directionStrings.append(direction.wrappedText)
                    }
                    dividedDirections["Cooking"] = directionStrings
                    activeView = .cooking
                }) {
                    ButtonText(text: "Cook alone", disabled: false)
                }
            }
            .padding()
        }
    }
}
