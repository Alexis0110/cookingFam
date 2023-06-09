//
//  RecipeCard.swift
//  CookingFam
//
//  Created by Alexis on 07.06.23.
//

import SwiftUI

struct RecipeCard: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<Recipe>
    let text: String
    let components: [Component]
    let selectedRecipe: Recipe
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    
    var body: some View {
        
        HStack {
            Image(systemName: "takeoutbag.and.cup.and.straw")
                .font(.system(size: 24))
                .foregroundColor(Color("Color5"))
            Spacer()
                .frame(width: 20)
            VStack{
                Text(text)
                    .font(.body)
                    .foregroundColor(Color("Text"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(height: 10)
                ForEach(components, id: \.self){component in
                    Text(component.name ?? "Error")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.gray)
                }
                Spacer()
            }
            
        }.padding()
            .background(Color("Background"))
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .padding(.horizontal)
            .onTapGesture {
                activeRecipe = selectedRecipe
                activeView = .details
            }
            
    }
}


