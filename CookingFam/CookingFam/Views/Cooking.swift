//
//  Cooking.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI


struct Cooking: View {
    @Binding var dividedDirections : [String:[String]]
    @Binding var activeView: ActiveView
    @State var selectedCook = ""
    @State var directionsDone : [String:Bool] = [:]
    @StateObject var vm = RecipesViewModel()
    
    var body: some View {
        ZStack{
            BackButton(activeView: $activeView, prevView: .search)
            VStack() {
                Headline(text: "Cooking")
                HStack(spacing: 8) {
                    if dividedDirections.keys.count > 1{
                        ForEach(Array(dividedDirections.keys), id: \.self){key in
                            Button(action: {
                                selectedCook = key
                            }) {
                                Text(key)
                                    .foregroundColor(Color("Text"))
                                    .font(.headline)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(selectedCook == key ? Color("Color3") : Color("Grayed"))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
                VStack{
                    let directions : [String] = dividedDirections[selectedCook] ?? []
                    
                    ForEach(directions, id: \.self) { direction in
                        HStack{
                            Image(systemName: directionsDone[direction] ?? false ? "checkmark.circle.fill" : "circle" )
                            Text(vm.removeDirectionID(direction:direction))
                                .foregroundColor(Color("Text"))
                                
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                            .background(Color("Background"))
                            .cornerRadius(10)
                            .onTapGesture {
                            directionsDone[direction]?.toggle()
                        }
                    }
                }
                
                
                Text("Back to search")
                    .onTapGesture {
                        activeView = .search
                    }.foregroundColor(Color("Text"))
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Color3"))
                            .cornerRadius(10)
            }.padding()
            }.onAppear(){
                selectedCook = Array(dividedDirections.keys)[0]
                for cook in dividedDirections.values {
                    for direction in cook {
                        directionsDone[direction] = false
                    }
                }
            }
            
    }
}
