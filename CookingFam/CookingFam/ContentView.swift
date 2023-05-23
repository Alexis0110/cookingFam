//
//  ContentView.swift
//  CookingFam
//
//  Created by Alexis on 11.05.23.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @StateObject var viewmodel = ViewModel()
    var body: some View {
        VStack{
            Text("CONTENT")
            Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }.background(Color.gray)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
