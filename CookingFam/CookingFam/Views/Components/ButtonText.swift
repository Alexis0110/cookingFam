//
//  ButtonText.swift
//  CookingFam
//
//  Created by Alexis on 27.06.23.
//

import Foundation
import SwiftUI

struct ButtonText: View {
    let text: String
    let disabled: Bool
    var body: some View {
        Text(text)
            .foregroundColor(Color("Text"))
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(disabled ? Color("Grayed") : Color("Color3"))
            .cornerRadius(10)
    }
}

