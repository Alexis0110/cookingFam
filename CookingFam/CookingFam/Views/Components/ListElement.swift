//
//  ListElement.swift
//  CookingFam
//
//  Created by Alexis on 30.06.23.
//

import Foundation
import SwiftUI
//able to display the entries inside of an given array
struct ListElement: View {
    @Binding var iterable : [String]
    let deleteable : Bool
    var body: some View {
        List {
            ForEach(iterable, id: \.self) { entry in
                Text(entry)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .background(Color("Background"))
                    .cornerRadius(10)
            }
            .onDelete(perform: deleteable ? deleteEntry : nil)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .padding(EdgeInsets(top: -8, leading: 0, bottom: -8, trailing: 0))
        }
        .listStyle(PlainListStyle())
    }
    private func deleteEntry(at offsets: IndexSet) {
        iterable.remove(atOffsets: offsets)
    }
}

