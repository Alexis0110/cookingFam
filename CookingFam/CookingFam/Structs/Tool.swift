//
//  Toolbar.swift
//  CookingFam
//
//  Created by Alexis on 23.05.23.
//

import Foundation
import UIKit

import SwiftUI

struct Tool: View {
    var body: some View {
        HStack {
            Button(action: {
                // Handle button 1 tap event
            }) {
                Text("Button 1")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Handle button 2 tap event
            }) {
                Text("Button 2")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // Add more buttons as needed
        }
        .padding()
        .background(Color.gray)
    }
}

