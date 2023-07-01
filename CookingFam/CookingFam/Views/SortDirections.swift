//
//  SortDirections.swift
//  CookingFam
//
//

import SwiftUI

struct SortDirections: View {
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    @Binding var cooks: [String]
    @Binding var dividedDirections: [String:[String]]
    
    @State private var selectedCook: String = ""
    @State private var directionDictionary: [String:String] = [:]
    @StateObject var vm = RecipesViewModel()
    
    var body: some View {
        let directions: [Direction] = activeRecipe.directionArray
        
        ZStack {
            BackButton(activeView: $activeView, prevView: .addCooks)
            
            VStack() {
                Headline(text: "Divide steps among cooks")
                
                CooksTabBar(cooks: cooks, selectedCook: $selectedCook)
                //displays all cooking directions. On click add them to the corresponding cook
                List {
                    ForEach(Array(directionDictionary.keys), id: \.self) { key in
                        Button(action: {
                            var cookDirections: [String] = dividedDirections[selectedCook] ?? []
                            
                            if !cookDirections.contains(key) {
                                cookDirections.append(key)
                                directionDictionary[key] = selectedCook
                            } else {
                                cookDirections.removeAll { $0 == key }
                                directionDictionary[key] = ""
                            }
                            
                            dividedDirections[selectedCook] = cookDirections.sorted()
                        }) {
                            Text(vm.removeDirectionID(direction: key))
                                .foregroundColor(getForegroundColor(for: key))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                                .background(Color("Background"))
                                
                        }
                        .disabled(directionDictionary[key] != selectedCook && directionDictionary[key] != "")
                        
                        .cornerRadius(10)
                    }.listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                }.listStyle(PlainListStyle())
                Button(action: {
                        activeView = .send_view
                }) {
                    ButtonText(text: directionDictionary.values.contains("") ? "Divide all steps first" : "Send to others", disabled: directionDictionary.values.contains(""))
                }
                .disabled(directionDictionary.values.contains(""))

            }
            .padding()
        }
        .onAppear() {
            for direction in directions {
                directionDictionary[direction.wrappedText] = ""
            }
            
            selectedCook = cooks[0]
            dividedDirections = [:]
        }
    }
    
    private func getForegroundColor(for key: String) -> Color {
        if directionDictionary[key] == "" {
            return .primary // Case 1: Selected (true)
        } else if directionDictionary[key] == selectedCook {
            return Color("Color5") // Case 2: Current selected cook
        } else {
            return .gray // Case 3: Default
        }
    }
}
