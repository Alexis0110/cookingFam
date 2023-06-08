//
//  RecipeSearch.swift
//  CookingFam
//
//  Created by Alexis on 06.06.23.
//

import Foundation
import SwiftUI
import CoreData


struct RecipeSearch: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<Recipe>
    
    @Binding var activeView: ActiveView
    @Binding var activeRecipe: Recipe
    
    var body: some View {
        ZStack {
            BackgroundColor()
            VStack{
    //            Button("Reload"){
    //                load()
    //            }
                ForEach(recipes, id: \.self){recipe in
                    RecipeCard(text: recipe.wrappedName, components: recipe.componentArray, selectedRecipe: recipe ,activeView: $activeView, activeRecipe: $activeRecipe)
                }
                .edgesIgnoringSafeArea(.all)
                
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    HStack{
                        Image(systemName: "qrcode")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(10)
                        Text("Scan QU-Code")
                            .padding(10)
                    }
                    .background(Color(hex: 0xffd3b6))
                    .onTapGesture {
                        activeView = .qr
                    }
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                            radius: 3,
                            x: 3,
                            y: 3)
                }
            }
        }
        
    }
    func load(){
        let firstName = "No-Bake Nut Cookies"
        let firstIngredients = ["1 c. firmly packed brown sugar", "1/2 c. evaporated milk", "1/2 tsp. vanilla", "1/2 c. broken nuts (pecans)", "2 Tbsp. butter or margarine", "3 1/2 c. bite size shredded rice biscuits"]
        let firstDirections = ["In a heavy 2-quart saucepan, mix brown sugar, nuts, evaporated milk and butter or margarine.", "Stir over medium heat until mixture bubbles all over top.", "Boil and stir 5 minutes more. Take off heat.", "Stir in vanilla and cereal; mix well.", "Using 2 teaspoons, drop and shape into 30 clusters on wax paper.", "Let stand until firm, about 30 minutes."]
        let firstComponents = ["brown sugar", "milk", "vanilla", "nuts", "butter", "bite size shredded rice biscuits"]
        
        firstIngredients.forEach {ingredient in
           let ingr = Ingredient(context: moc)
           ingr.name = ingredient
           ingr.recipe = Recipe(context: moc)
           ingr.recipe?.name = firstName

           try? moc.save()
        }

        firstDirections.forEach {direction in
           let dir = Direction(context: moc)
           dir.text = direction
           dir.recipe = Recipe(context: moc)
           dir.recipe?.name = firstName

           try? moc.save()
        }

        firstComponents.forEach {component in
           let comp = Component(context: moc)
           comp.name = component
           comp.recipe = Recipe(context: moc)
           comp.recipe?.name = firstName

           try? moc.save()
        }
        
        let secondName = "Jewell Ball'S Chicken"
        let secondIngredients = ["1 small jar chipped beef, cut up", "4 boned chicken breasts", "1 can cream of mushroom soup", "1 carton sour cream"]
        let secondDirections = ["Place chipped beef on bottom of baking dish.", "Place chicken on top of beef.", "Mix soup and cream together; pour over chicken. Bake, uncovered, at 275 for 3 hours."]
        let secondComponents = ["beef", "chicken breasts", "cream of mushroom soup", "sour cream"]
        
        secondIngredients.forEach {ingredient in
           let ingr = Ingredient(context: moc)
           ingr.name = ingredient
           ingr.recipe = Recipe(context: moc)
           ingr.recipe?.name = secondName

           try? moc.save()
        }

        secondDirections.forEach {direction in
           let dir = Direction(context: moc)
           dir.text = direction
           dir.recipe = Recipe(context: moc)
           dir.recipe?.name = secondName

           try? moc.save()
        }

        secondComponents.forEach {component in
           let comp = Component(context: moc)
           comp.name = component
           comp.recipe = Recipe(context: moc)
           comp.recipe?.name = secondName

           try? moc.save()
        }
        
        let thirdName = "Creamy Corn"
        let thirdIngredients = ["2 (16 oz.) pkg. frozen corn", "1 (8 oz.) pkg. cream cheese, cubed", "1/3 c. butter, cubed", "1/2 tsp. garlic powder", "1/2 tsp. salt", "1/4 tsp. pepper"]
        let thirdDirections = ["In a slow cooker, combine all ingredients. Cover and cook on low for 4 hours or until heated through and cheese is melted. Stir well before serving. Yields 6 servings."]
        let thirdComponents = ["frozen corn", "cream cheese", "butter", "garlic powder", "salt", "pepper"]
        
        thirdIngredients.forEach {ingredient in
           let ingr = Ingredient(context: moc)
           ingr.name = ingredient
           ingr.recipe = Recipe(context: moc)
           ingr.recipe?.name = thirdName

           try? moc.save()
        }

        thirdDirections.forEach {direction in
           let dir = Direction(context: moc)
           dir.text = direction
           dir.recipe = Recipe(context: moc)
           dir.recipe?.name = thirdName

           try? moc.save()
        }

        thirdComponents.forEach {component in
           let comp = Component(context: moc)
           comp.name = component
           comp.recipe = Recipe(context: moc)
           comp.recipe?.name = thirdName

           try? moc.save()
        }
        

        
    }
}
