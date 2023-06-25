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
            BackgroundColor()
            VStack(spacing: 16) {
                
                HStack {
                    BackButton(activeView: $activeView, prevView: .search)
                        .padding(.leading, 16)
                    Spacer()
                }
                HStack {
                    ForEach(Array(dividedDirections.keys), id: \.self){key in
                        Button(action: {
                            selectedCook = key
                        }) {
                            HStack{
                                Text(key)
                                    .padding()
                                    .foregroundColor(selectedCook == key ? .white : .blue)
                                    .background(selectedCook == key ? Color.blue : Color.clear)
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
                                .foregroundColor(Color.primary)
                        }.onTapGesture {
                            directionsDone[direction] = true
                        }
                    }

                    Text("Finish Cooking")
                        .foregroundColor(Color(hex: 0xff8b94))
                    .onTapGesture {
                        activeView = .doneCooking
                    }
                }
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
}
