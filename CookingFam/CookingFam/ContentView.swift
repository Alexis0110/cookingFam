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
            }  else if activeView == .addCooks{
                AddCooksDialog(activeView: $activeView, cooks: $cooks)
            } else if activeView == .sort_directions{
                SortDirections(activeView: $activeView, activeRecipe: $activeRecipe, cooks: $cooks, dividedDirections: $dividedDirections)
            } else if activeView == .send_view{
                SendView(dividedDirections: $dividedDirections)
            } else if activeView == .accept_view{
                AcceptView(dividedDirections: $dividedDirections, activeView: $activeView)
            } else if activeView == .cooking{
                Cooking(dividedDirections: $dividedDirections, activeView: $activeView)
            }
        }
    }
}

enum ActiveView {
    case search, details, qr, sort_directions, addCooks, send_view, accept_view, cooking

}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

extension UIViewController {
// TODO: add this somehow in every view where a Textfield could add a keyboard
//    this code should dismiss keyboard every time you click outside of the keyboard
//    Now in every UIViewController, all you have to do is call this function:
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.hideKeyboardWhenTappedAround()
//    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
