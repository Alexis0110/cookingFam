//
//  BackgroundColor.swift
//  CookingFam
//
//  Created by Alexis on 08.06.23.
//

import Foundation
import SwiftUI

struct BackgroundColor : View{
    var body : some View{
        ZStack{
            // Background color
            LinearGradient(gradient: Gradient(colors: [Color("BackBlue"), Color("BackOrange")]), startPoint: .top, endPoint: .bottom)
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            // Blur effect
            LinearGradient(gradient: Gradient(colors: [.clear, .blue]), startPoint: .top, endPoint: .bottom)
                .blur(radius: 500)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
