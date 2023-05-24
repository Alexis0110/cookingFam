//
//  ContentView.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var recipesViewModel = RecipesViewModel()
    
    @State private var name = ""
    var body: some View {
        VStack{
            List{
                ForEach(recipesViewModel.recipes){ recipe in
                    Text(recipe.name ?? "Error")
                }
                .onDelete(perform: delete)
                
                
            }
            HStack{
                TextField("New Recipe", text: $name)
                Button("Add"){
                    recipesViewModel.addData(name: name)
                    name = ""
                }
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
