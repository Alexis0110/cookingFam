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
                    ForEach(activeRecipe.directionArray, id: \.self) {direction in
                        Text(direction.text ?? "Error")
                            .font(.body)
                    }
                }
                Text("print")
                    .onTapGesture {
                        print(activeRecipe.directionArray)
                    }
            }
        }
    }
}

