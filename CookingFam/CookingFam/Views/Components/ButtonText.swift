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
    
    var body: some View {
        Text(text)
            .foregroundColor(Color("Text"))
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background( Color("Color3"))
            .cornerRadius(10)
    }
}

struct ButtonTextDisabled: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(Color("Text"))
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("Grayed"))
            .cornerRadius(10)
    }
}
