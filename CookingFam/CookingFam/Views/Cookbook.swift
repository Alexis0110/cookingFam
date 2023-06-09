//
//  Cookbook.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI


struct Cookbook: View {
    var body: some View {
        ZStack{
            BackgroundColor()
            
            VStack{
                //TODO: remove buttons
                Button("delete"){
                    let dataController = DataController()
                    dataController.deleteAll()
                }
                Button("reload"){
                    let dataController = DataController()
                    dataController.importCSV()
                }
                Text("BOOK")
            }
        }
        
    }
}
