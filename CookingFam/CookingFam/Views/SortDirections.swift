//
//  SortDirections.swift
//  CookingFam
//
//  Created by Kober, Ingo on 09.06.23.
//

import SwiftUI

struct SortDirections: View {
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    @Binding var cooks: [String]
    @State var dividedDirections = [String:[String]]()
    @State private var selectedCook: String = ""
    @State private var selection: UUID?
    
    
    var body: some View {
        var directions: [Direction] = activeRecipe.directionArray
        var texts : [String] = [""]
        ForEach (directions){ d in
            Text(texts[0])
            //print(d.text ?? "error")
        }
        
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
            .padding()
            NavigationStack {
                List(directions, id: \.self, selection: $selection) { direction in
                    let text = removeDirectionID(direction: direction.text ?? "Error")
                    Text(text)
                        .font(.body)
                }
                .navigationTitle("List Selection")
                .environment(\.editMode, .constant(.active))
            }
//            HStack{
//                List(directions, id: \.self, selection: $selection){ direction in
//                    let text = removeDirectionID(direction: direction.text ?? "Error")
//                    Text(text)
//                        .font(.body)
//                }
//                .navigationTitle("Directions for " + selectedCook)
//                .toolbar{
//                    EditButton()
//                }
//                List {
//                    ForEach(activeRecipe.directionArray) {direction in
//                        VStack{
//                            let text = direction.text?.dropFirst(2) ?? "Error"
//                            Text(text)
//                                .font(.body)
//                        }.onTapGesture {
//                            if selectedCook == ""{
//                                selectedCook = cooks[0]
//                            }
//                            var cook_directions : [String] = dividedDirections[selectedCook] ?? []
//                            if !cook_directions.contains(direction.text ?? "Error"){
//                                cook_directions.append(direction.text ?? "Error")
//                            }
//                            dividedDirections[selectedCook] = cook_directions.sorted()
//                            print(dividedDirections)
//                            print(directions)
//                        }
//                    }
//                }
//            }
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
}
