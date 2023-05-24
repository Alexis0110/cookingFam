//
//  CookingFamApp.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import SwiftUI
import UIKit

@main
struct CookingFamApp: App {
    
    @StateObject  private var dataController = DataController(name: "Model")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
