//
//  ContentView.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State var activeView : ActiveView = .search
    @State var activeRecipe : Recipe = Recipe()
    var body: some View {
        ZStack {
            BackgroundColor()
            if activeView == .search {
                TabView {
                    
                    RecipeSearch(activeView: $activeView, activeRecipe: $activeRecipe)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Recipes")
                        }
                    Cookbook()
                        .tabItem {
                            Image(systemName: "book")
                            Text("Cookbook")
                        }
                    
                    
                    
                }
                .edgesIgnoringSafeArea(.all)
            } else if activeView == .qr{
                QrScanner(activeView: $activeView)
            } else if activeView == .details{
                RecipeDetails(activeView: $activeView, activeRecipe: $activeRecipe)
            } else if activeView == .sort_directions{
                SortDirections(activeView: $activeView, activeRecipe: $activeRecipe)
            }
        }
    }
}

enum ActiveView {
    case search, details, qr, sort_directions
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
