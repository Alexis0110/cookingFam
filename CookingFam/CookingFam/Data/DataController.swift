//
//  DataController.swift
//  CookingFam
//
//  Created by Alexis on 24.05.23.
//

import Foundation
import CoreData

class DataController : ObservableObject{
    let container = NSPersistentContainer(name: "Model")
    
    init(){
        container.loadPersistentStores{ _, error in
            if let error = error{
                print("CoreData Error:\(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
    
    func importCSV(){ //TODO: stop double imports
        //CSV structure: id,title,ingredients,directions,link,source,NER
        
        guard let path = Bundle.main.path(forResource: "Recipe", ofType: "csv") else {
            print("CSV not found")
            return
        }
        
        do{
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let csvString = String(data: data, encoding: .utf8)
            let rows = csvString?.components(separatedBy: "\n")
            
            
            if let rows = rows {
                for row in rows {
                    // seperade data from nested data, e.g. A;[X;Y,d,v;Z];B;C
                    var nested = false
                    var field = ""
                    var data_columns: [String] = []
                    if row.contains(";"){
                        for c in row {
                            if c == "[" || c == "]" {
                                nested.toggle()
                            }else if c == ";" && !nested {
                                data_columns.append(field)
                                field = ""
                            }else{
                                field.append(c)
                            }
                        }
                        if !field.isEmpty {
                            data_columns.append(field)
                        }
                    }
                    if data_columns != []{
                        if let newRecipe = NSEntityDescription.insertNewObject(forEntityName: "Recipe", into: container.viewContext) as? Recipe {
                            newRecipe.name = data_columns[1]
                            let ingredients = data_columns[2].components(separatedBy: ";")
                            ingredients.forEach{ingredient in
                                if let newIngredient = NSEntityDescription.insertNewObject(forEntityName: "Ingredient", into: container.viewContext) as? Ingredient {
                                    newIngredient.name = ingredient
                                    newIngredient.recipe = newRecipe
                                    newIngredient.recipe?.name = data_columns[1]
                                }
                            }
                            var i = 0
                            let directions = data_columns[3].components(separatedBy: ";")
                            directions.forEach{direction in
                                if let newDirection = NSEntityDescription.insertNewObject(forEntityName: "Direction", into: container.viewContext) as? Direction {
                                    // add number to keep right order for directions
                                    var dir_text = direction
                                    if direction.first == " "{
                                        dir_text = String(direction.dropFirst())
                                    }
                                    newDirection.text = (String(i) + ":") + dir_text
                                    newDirection.recipe = newRecipe
                                    newDirection.recipe?.name = data_columns[1]
                                    i = i+1
                                }
                            }
                            let components = data_columns[6].components(separatedBy: ";")
                            components.forEach{component in
                                if let newComponent = NSEntityDescription.insertNewObject(forEntityName: "Component", into: container.viewContext) as? Component {
                                    newComponent.name = component
                                    newComponent.recipe = newRecipe
                                    newComponent.recipe?.name = data_columns[1]
                                }
                            }
                        }
                    }
                }
            }
            try container.viewContext.save()
        } catch {
            print("Error while importing CSV: \(error)")
        }
    }
    
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Recipe.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)
        
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Ingredient.fetchRequest()
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        _ = try? container.viewContext.execute(batchDeleteRequest2)
        
        let fetchRequest3: NSFetchRequest<NSFetchRequestResult> = Direction.fetchRequest()
        let batchDeleteRequest3 = NSBatchDeleteRequest(fetchRequest: fetchRequest3)
        _ = try? container.viewContext.execute(batchDeleteRequest3)
        
        let fetchRequest4: NSFetchRequest<NSFetchRequestResult> = Component.fetchRequest()
        let batchDeleteRequest4 = NSBatchDeleteRequest(fetchRequest: fetchRequest4)
        _ = try? container.viewContext.execute(batchDeleteRequest4)
    }
    
}
