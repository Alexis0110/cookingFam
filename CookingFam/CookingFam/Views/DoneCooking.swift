//
//  DoneCooking.swift
//  CookingFam
//
//  Created by Alexis on 25.06.23.
//

import Foundation
import SwiftUI


struct DoneCooking: View {
    @Environment(\.managedObjectContext) var moc
    
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    @State var isMainCook = true
    
    var body: some View {
        ZStack{
            VStack{
                Headline(text: "Bon appétit")
                Text("Would you like to add \(activeRecipe.wrappedName) to your cookbook?")
                if isMainCook == true{
                    Button(action: {
                        activeRecipe.cookbook = Cookbook(context: moc)
                        activeRecipe.cookbook?.name = "Book"
                        
                        try? moc.save()
                    }) {
                        ButtonText(text: "Add to cookbook", disabled: false)
                    }
                }
                //                Button(action: {
//                    activeRecipe.cookbook = Cookbook(context: moc)
//                    activeRecipe.cookbook?.name = "Book"
//                    
//                    try? moc.save()
//                }) {
//                    ButtonText(text: "Add to cookbook", disabled: false)
//                }
                ButtonText(text: "Back to search", disabled: false)
                    .onTapGesture {
                        activeView = .search
                    }
            }.padding()
        }.onAppear(){
            if activeRecipe.wrappedName == "NOTTHEMAINCOOK"{
                isMainCook = false
            }
        }
    }
    
}
