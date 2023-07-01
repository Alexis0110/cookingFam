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
                        CooksTabBar(cooks: Array(dividedDirections.keys), selectedCook: $selectedCook)
                    }
                }
                .padding()
                
                let directions : [String] = dividedDirections[selectedCook] ?? []
                //displays the direcions of the selected cook in CooksTabBar
                List{
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
                            
                    }.listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
                }.listStyle(PlainListStyle())
                
                
                ButtonText(text: "Finish cooking", disabled: false)
                    .onTapGesture {
                        dividedDirections = [:]
                        activeView = .doneCooking
                    }
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
