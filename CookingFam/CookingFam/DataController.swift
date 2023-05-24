//
//  DataController.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import Foundation
import CoreData

class DataController : ObservableObject{
    var container : NSPersistentContainer
    
    init(name: String){
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores{ _, error in
            if let error = error{
                print("CoreData Error:\(error.localizedDescription)")
            }
        }
    }
}
