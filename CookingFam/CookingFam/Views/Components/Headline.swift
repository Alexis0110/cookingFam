//
//  Headline.swift
//  CookingFam
//
//  Created by Alexis on 27.06.23.
//

import Foundation
import SwiftUI

struct Headline: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .padding()
    }
}
