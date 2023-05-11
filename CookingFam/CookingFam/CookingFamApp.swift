//
//  CookingFamApp.swift
//  CookingFam
//
//  Created by Alexis on 11.05.23.
//

import SwiftUI

@main
struct CookingFamApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
