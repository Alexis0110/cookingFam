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
    @State var cooks: [String] = []
    @State var dividedDirections = [String:[String]]()

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
                    Book(activeView: $activeView, activeRecipe: $activeRecipe)
                        .tabItem {
                            Image(systemName: "book")
                            Text("Cookbook")
                        }
                }
                .accentColor(Color("Color5"))
                .edgesIgnoringSafeArea(.all)
            } else if activeView == .details{
                RecipeDetails(activeView: $activeView, activeRecipe: $activeRecipe, dividedDirections: $dividedDirections)
            } else if activeView == .addCooks{
                AddCooksDialog(activeView: $activeView, cooks: $cooks)
            } else if activeView == .sort_directions{
                SortDirections(activeView: $activeView, activeRecipe: $activeRecipe, cooks: $cooks, dividedDirections: $dividedDirections)
            } else if activeView == .send_view{
                SendView(dividedDirections: $dividedDirections,activeView: $activeView)
            } else if activeView == .accept_view{
                AcceptView(dividedDirections: $dividedDirections, activeView: $activeView, activeRecipe: $activeRecipe)
            } else if activeView == .cooking{
                Cooking(dividedDirections: $dividedDirections, activeView: $activeView)
            } else if activeView == .doneCooking{
                DoneCooking(activeView: $activeView, activeRecipe: $activeRecipe)
            }
        }
    }
}

enum ActiveView {
    case search, details, sort_directions, addCooks, send_view, accept_view, cooking, doneCooking

}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    func containsSubstringRegex(_ substring: String) -> Bool {
        do {
            let pattern = try NSRegularExpression(pattern: substring, options: .caseInsensitive)
            let range = NSRange(location: 0, length: self.utf16.count)
            return pattern.firstMatch(in: self, options: [], range: range) != nil
        } catch {
            print("Regex error: \(error.localizedDescription)")
        }
        return false
    }
}
