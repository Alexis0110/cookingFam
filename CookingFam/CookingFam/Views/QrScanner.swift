//
//  QrScanner.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI


struct QrScanner: View {
    @Binding var activeView: ActiveView
    var body: some View {
        ZStack {
            BackgroundColor()
            VStack{
                VStack{
                    Image(systemName: "chevron.backward")
                }.onTapGesture {
                    activeView = .search
                }
                Text("SCAN CODE")
            }
        }
    }
}
