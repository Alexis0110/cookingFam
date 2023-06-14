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
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                BackButton(activeView: $activeView, prevView: .details)
                    .padding(.leading, 16)
                Spacer()
            }
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

