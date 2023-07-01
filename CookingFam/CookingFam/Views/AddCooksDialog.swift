//
//  AddCooksDialog.swift
//  CookingFam
//
//  Created by Alexis on 15.06.23.
//

import Foundation
import SwiftUI

struct AddCooksDialog: View {
    @Binding var activeView: ActiveView
    @Binding var cooks: [String]
    @State private var newEntry = ""
    

    var body: some View {
        ZStack {
            BackButton(activeView: $activeView, prevView: .details)
            VStack {
                Headline(text: "Add all awesome chefs")
                HStack{
                    // adds randomness to default entry for inputfield
                    let awesome_words = ["Awesome","impressive","superior","topnotch","finest","unrivaled","unsurpassable",""]
                    let cook_words = ["cook","chef","knife-swinger","deep-fryer","food-creator","vegetable-smasher"]
                    TextField((awesome_words.randomElement() ?? "awesome") + " " + (cook_words.randomElement() ?? "chef"), text: $newEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accentColor(Color("Color5"))
                    .padding()
                    Button("Add") {
                        var id = ""
                        let text = newEntry.capitalizingFirstLetter()
                        if cooks.contains(text){
                            id = String(returnUniqueID(entry: text, id: 1))
                        }
                        cooks.append(text + id)
                        newEntry = ""
                        hideKeyboard()
                    }
                    .disabled(newEntry == "")
                    .foregroundColor(Color("Color5"))
                    .padding()

                }
                if cooks.isEmpty{
                    Spacer()
                } else {
                    //displays added cooks
                    ListElement(iterable: $cooks, deleteable: true)
                }
                
                Button(action: {
                        activeView = .sort_directions
                }) {
                    ButtonText(text: cooks.count == 0 ? "Add some cooks first" : "Continue", disabled: cooks.count == 0)
                }
                .disabled(cooks.count == 0)
            }
            .padding()
        }.onAppear(){
            cooks = []
        }
    }
    
    
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    
    private func returnUniqueID(entry: String, id: Int) -> Int{
        if cooks.contains(entry + String(id)){
            return returnUniqueID(entry: entry, id: id+1)
        }
        return id
    }

}

