//
//  BackButton.swift
//  CookingFam
//
//  Created by Luke on 09.06.23.
//

import Foundation
import SwiftUI

struct BackButton: View {
    @Binding var activeView: ActiveView
    let prevView: ActiveView
    
    var body: some View {
        VStack{
            Image(systemName: "chevron.left")
                .font(.title2)
        }.foregroundColor(Color("Color5"))
            .position(x: 10)
        .padding(EdgeInsets(top: 35, leading: 15, bottom: 0, trailing: 0))
        .onTapGesture {
            activeView = prevView
        }
    }
}
