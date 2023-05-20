//
//  ContentView.swift
//  CatDogMVVM
//
//  Created by Miriam Föller-Nord on 26.12.22.
//
// this is the view 

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        if viewModel.isUnlocked {
            Text(viewModel.pet)
                .font(.system(size: 150))
                .padding()
                .onTapGesture {
                    // Switcht pet
                    viewModel.switchPet()
                }
        } else {
            Button("Unlock CatDog") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
