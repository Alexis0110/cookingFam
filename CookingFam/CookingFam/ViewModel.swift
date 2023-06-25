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
    
    func removeDirectionID(direction: String) -> String {
        let ind :Int = direction.distance(from: direction.startIndex, to: direction.firstIndex(of: ":") ?? direction.startIndex)
        var text = direction
        for _ in 0...ind {
            text.remove(at: direction.startIndex)
        }
        return text
    }
  
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
