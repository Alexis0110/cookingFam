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
                Text("Add Entry")
                    .font(.title)
                    .padding()
                HStack{
                TextField("Enter entry", text: $newEntry)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
 
                    Button("Add") {
                        cooks.append(newEntry)
                        newEntry = ""
                    }
                    .padding()
                    
                    
                }
                
                List {
                    ForEach(cooks, id: \.self) { entry in
                        Text(entry)
                    }
                    .onDelete(perform: deleteEntry)
                }
                .padding()
                Button("Continue") {
                    activeView  = .sort_directions
                }
                .padding()
            }
        }
    }
    
    private func deleteEntry(at offsets: IndexSet) {
        cooks.remove(atOffsets: offsets)
    }
}

