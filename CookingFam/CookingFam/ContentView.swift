//
//  ContentView.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var recipesViewModel = RecipesViewModel()
    @State private var selectedTab = 1
//    @FetchRequest var recipes: FetchedResults<Recipe>
    var body: some View {
            TabView (selection: $selectedTab){
                QrScanner()
                    .tabItem {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan QR-Code")
                    }
                RecipeSearch()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Recipes")
                    }.tag(1)
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
    
    func delete(at offsets : IndexSet){
        recipesViewModel.deleteItem(at: offsets)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
