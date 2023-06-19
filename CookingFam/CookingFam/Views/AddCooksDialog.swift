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
            BackgroundColor()
            
            VStack {
                HStack {
                    BackButton(activeView: $activeView, prevView: .details)
                        .padding(.leading, 16)
                    
                    Spacer()
                }

                Text("Add all awesome chefs")
                    .font(.title)
                    .padding()
                HStack{
                    // adds randomness to default entry for inputfield
                    let awesome_words = ["Awesome","impressive","superior","topnotch","finest","unrivaled","unsurpassable",""]
                    let cook_words = ["cook","chef","knife-swinger","deep-fryer","food-creator","vegetable-smasher"]
                    TextField((awesome_words.randomElement() ?? "awesome") + " " + (cook_words.randomElement() ?? "chef"), text: $newEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    // TODO: add "enter pressed" to add chefs as well
                    Button("Add") {
                        // adds uniqueness with id
                        var id = ""
                        let text = newEntry.capitalizingFirstLetter()
                        if cooks.contains(text){
                            id = String(returnUniqueID(entry: text, id: 1))
                        }
                        cooks.append(text + id)
                        newEntry = ""
                    }
                    .disabled(newEntry == "")
                    .padding()

                }
                
                List {
                    ForEach(cooks, id: \.self) { entry in
                        Text(entry)
                    }
                    .onDelete(perform: deleteEntry)
                }

                .listRowBackground(Color.clear)
                

                .padding()
                Button("Continue") {
                    activeView  = .sort_directions
                }

                .disabled(cooks.count == 0)

                .padding()
            }
        }
    }
    
    private func deleteEntry(at offsets: IndexSet) {
        cooks.remove(atOffsets: offsets)
    }
    private func returnUniqueID(entry: String, id: Int) -> Int{
        if cooks.contains(entry + String(id)){
            return returnUniqueID(entry: entry, id: id+1)
        }
        return id
    }

}

