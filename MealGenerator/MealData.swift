//
//  MealData.swift
//  MealGenerator
//
//  Created by Vinodh Sekhar on 5/20/23.
//

import Foundation

struct MealData: Decodable, Hashable {
    
    let meals: [Meal]
    
}

struct Meal: Decodable, Hashable {
    
    let name: String
    let imageUrlString: String
    let ingredients: [Ingredient]
    let instructions: String
    let idMeal: String
    
}

extension Meal {
    init (from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()
        let mealDictionary = try container.decode([String: String?].self)
        
        //Parse the ingredients
        var index = 1
        var ingredients: [Ingredient] = []
        
        while let ingredient = mealDictionary["strIngredient\(index)"] as? String,
                let measure = mealDictionary["strMeasure\(index)"] as? String,
                !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
        
        //Initialize Values
        self.ingredients = ingredients
        name = mealDictionary["strMeal"] as? String ?? ""
        imageUrlString = mealDictionary["strMealThumb"] as? String ?? ""
        idMeal = mealDictionary["idMeal"] as? String ?? ""
        instructions = mealDictionary["strInstructions"] as? String ?? ""
    }
    
    
}

//Ingredient Class
struct Ingredient: Decodable, Hashable {
    
    let name: String
    let measure: String
    
}
