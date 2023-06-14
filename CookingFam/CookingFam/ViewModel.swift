//
//  ViewModel.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import Foundation
import SwiftUI
import LocalAuthentication
import CoreData


class RecipesViewModel: ObservableObject{
    @Environment(\.managedObjectContext) var moc
    private var dataController = DataController()
    

  
}

extension ContentView {
    @MainActor class ViewModel:ObservableObject{
    }
}
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
