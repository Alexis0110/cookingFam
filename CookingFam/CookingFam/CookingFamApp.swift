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
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .onAppear(){
                    //only reload the data if the database is empty
                    if dataController.hasNoValues(){
                        dataController.deleteAll()
                        dataController.importCSV()
                    }
                    //check if the cookbook already exist. if not create it
                    if dataController.hasNoBook(){
                        let book = Cookbook(context: dataController.container.viewContext)
                        book.name = "Book"

                        try? dataController.container.viewContext.save()
                    }
                        
                }
        }
    }
}
