//
//  SortDirectionsCard.swift
//  CookingFam
//
//  Created by Alexis on 27.06.23.
//

import Foundation
import SwiftUI

struct SortDirectionsCard: View {
    let text: String
    
    var body: some View {
        HStack{
            Text(text)
                
        }.font(.body)
            .foregroundColor(Color("Text"))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("Background"))
            .padding()
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
            .padding(.horizontal)
            
            
    }
}
