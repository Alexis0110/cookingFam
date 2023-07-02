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
    
    func returnUniqueID(cooks: [String],entry: String, id: Int) -> Int{
        if cooks.contains(entry + String(id)){
            return returnUniqueID(cooks: cooks,entry: entry, id: id+1)
        }
        return id
    }
    
}

extension ContentView {
    @MainActor class ViewModel:ObservableObject{
    }
}

