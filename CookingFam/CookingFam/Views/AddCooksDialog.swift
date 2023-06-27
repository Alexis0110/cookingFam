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
                    List {
                        ForEach(cooks, id: \.self) { entry in
                            Text(entry)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                                .background(Color("Background"))
                                .cornerRadius(10)
                        }
                        .onDelete(perform: deleteEntry)
                        .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                    }
                     .listStyle(PlainListStyle())
                }
                   
                if cooks.count != 0{
                    Button(action: {activeView  = .sort_directions}) {
                        ButtonText(text: "Continue")
                    }
                    .padding()
                } else {
                    Button(action: {}) {
                        ButtonTextDisabled(text: "Add some chefs first!")
                    }
                    .padding()
                }
            }
        }.onAppear(){
            cooks = []
        }
    }
    
    
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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

