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
        }.foregroundColor(Color(hex: 0xff8b94))
        .onTapGesture {
            activeView = prevView
        }
    }
}
