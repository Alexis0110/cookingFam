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

    @State var dividedDirections = [String:[String]]()
    @State private var selectedCook: String = ""
    @State private var selection: UUID?
    @State var directionDictionary : [String:String] = [:]
    

    
    var body: some View {
        var directions: [Direction] = activeRecipe.directionArray

        VStack(spacing: 16) {
            
            HStack {
                BackButton(activeView: $activeView, prevView: .addCooks)
                    .padding(.leading, 16)
                Spacer()
            }
            HStack {
                ForEach(cooks, id: \.self){cook in
                    Button(action: {

                        selectedCook = cook
                    }) {
                        Text(cook)
                            .padding()
                            .foregroundColor(selectedCook == cook ? .white : .blue)
                            .background(selectedCook == cook ? Color.blue : Color.clear)
                            .cornerRadius(10)
                    }
                }
            }
            .onAppear(){
                for direction in directions {
                    directionDictionary[direction.wrappedText] = ""
                    }
                selectedCook = cooks[0]
            }
            .padding()
            List {
                ForEach(Array(directionDictionary.keys), id: \.self) { key in
                    Button(action: {
                        // Perform action when button is tapped
                        // For example, toggle the value of the selected entry
                        
                        var cook_directions : [String] = dividedDirections[selectedCook] ?? []
                        if !cook_directions.contains(key){
                            cook_directions.append(key)
                            directionDictionary[key] = selectedCook
                        } else{
                            cook_directions = cook_directions.filter { $0 != key }
                            directionDictionary[key] = ""

                        }
                        dividedDirections[selectedCook] = cook_directions.sorted()
                        
                    }) {
                        Text(removeDirectionID(direction:key))
                            .foregroundColor(getForegroundColor(for: key)) // Make unselectable entries gray
                    }
                    .disabled(directionDictionary[key] != selectedCook && directionDictionary[key] != "") // Disable unselectable entries
                }
            }

        }
    }
    func removeDirectionID(direction: String) -> String {
        let ind :Int = direction.distance(from: direction.startIndex, to: direction.firstIndex(of: ":") ?? direction.startIndex)
        var text = direction
        for _ in 0...ind {
            text.remove(at: direction.startIndex)
        }
        return text
    }
    private func getForegroundColor(for key: String) -> Color {
        if directionDictionary[key] == "" {
            return .primary // Case 1: Selected (true)
        } else if directionDictionary[key] == selectedCook {
            return .blue // Case 2: Current selected cook
        } else {
            return .gray // Case 3: Default
        }
    }
}
