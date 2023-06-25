//
//  DoneCooking.swift
//  CookingFam
//
//  Created by Alexis on 25.06.23.
//

import Foundation
import SwiftUI


struct DoneCooking: View {
    @Binding var activeView: ActiveView
    
    var body: some View {
        ZStack{
            Text("Back to search")
                .onTapGesture {
                    activeView = .search
                }
        }
    }
    
}
