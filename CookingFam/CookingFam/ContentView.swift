//
//  ContentView.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    var body: some View {
            TabView {
//                QrScanner()
//                    .tabItem {
//                        Image(systemName: "qrcode.viewfinder")
//                        Text("Scan QR-Code")
//                    }
                RecipeSearch()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Recipes")
                    }
                Cooking()
                    .tabItem {
                        Image(systemName: "oven")
                        Text("Cooking")
                    }
                Cookbook()
                    .tabItem {
                        Image(systemName: "book")
                        Text("Cookbook")
                    }
        }.padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
