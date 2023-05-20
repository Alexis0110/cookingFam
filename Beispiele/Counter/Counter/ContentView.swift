//
//  ContentView.swift
//  Counter
//
//  Created by Miriam Föller-Nord on 16.11.22.
//

import SwiftUI

struct ContentView: View {
    @State var count: Int=0
    var body: some View {
        VStack {
            Text("Count: \(count)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.red)
            HStack {
                Button("Reset") {
                    self.count=0
                }
                .padding(.all)
                Button("Increment") {
                    self.count+=1
                }
                .padding(.all)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
