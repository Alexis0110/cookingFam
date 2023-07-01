//
//  CooksTabBar.swift
//  CookingFam
//
//  Created by Alexis on 30.06.23.
//

import Foundation
import SwiftUI
//displayes all cooks inside a tab view. the active cook can be changed by clicking on the box
struct CooksTabBar: View {
    let cooks : [String]
    @Binding var selectedCook : String
    var body: some View {
        HStack(spacing: 8) {
            ForEach(cooks, id: \.self) { cook in
                Button(action: {
                    selectedCook = cook
                }) {
                    Text(cook)
                        .foregroundColor(Color("Text"))
                        .font(.headline)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(selectedCook == cook ? Color("Color3") : Color("Grayed"))
                        .cornerRadius(10)
                }
            }
        }
    }
}
