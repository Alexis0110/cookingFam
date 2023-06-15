//
//  SortDirections.swift
//  CookingFam
//
//  Created by Kober, Ingo on 09.06.23.
//

import SwiftUI

struct SortDirections: View {
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    @Binding var cooks: [String]
    @Binding var dividedDirections: [[String]]
    @State private var selectedOption: String = ""

    
    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                BackButton(activeView: $activeView, prevView: .addCooks)
                    .padding(.leading, 16)
                Spacer()
            }
            HStack {
                ForEach(cooks, id: \.self){cook in
                    Button(action: {
                        selectedOption = cook
                    }) {
                        Text(cook)
                            .padding()
                            .foregroundColor(selectedOption == cook ? .white : .blue)
                            .background(selectedOption == cook ? Color.blue : Color.clear)
                            .cornerRadius(10)
                    }
                }
                      
                   }
                   .padding()
            HStack{
                List {
                    ForEach(activeRecipe.directionArray) {direction in
                        VStack{
                            let text = direction.text?.dropFirst()
                            Text(text ?? "Error")
                                .font(.body)
                        }
                    }
                }
            }
        }
    }
}

