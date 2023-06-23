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
    
    var body: some View {
        ZStack{
            BackgroundColor()
            VStack(spacing: 16) {
                
                HStack {
                    BackButton(activeView: $activeView, prevView: .addCooks)
                        .padding(.leading, 16)
                    Spacer()
                }
                HStack {
                    ForEach(Array(dividedDirections.keys), id: \.self){key in
                        Button(action: {

                            selectedCook = key
                        }) {
                            Text(key)
                                .padding()
                                .foregroundColor(selectedCook == key ? .white : .blue)
                                .background(selectedCook == key ? Color.blue : Color.clear)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                VStack{
                    var directions : [String] = dividedDirections[selectedCook] ?? []
                            ForEach(directions, id: \.self){direction in
                                Button(action: {
                                    // Perform action when button is tapped
                                    // For example, toggle the value of the selected entry
                                    
                                }) {
                                    Text(direction)
                                        .foregroundColor(Color.primary) // Make unselectable entries gray
                                }
                            }
                        }
                        
                    }
                }.onAppear(){
                    selectedCook = Array(dividedDirections.keys)[0]
                }
            }
        }
