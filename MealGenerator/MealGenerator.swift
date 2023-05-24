//
//  MealGenerator.swift
//  MealGenerator
//
//  Created by Vinodh Sekhar on 5/20/23.
//

import Foundation
import Combine

final class MealGenerator: ObservableObject {
    
    //Pointer to the current Meal and its Image
    @Published var currentMeal: Meal?
    @Published var currentImageURLString: String?
    
    //Desserts is an array of meals
    public var listOfDesserts = [Meal]()

    private var cancellable: AnyCancellable?
    
    //Get all the Dessert Data
    func getDesserts() {
        
        //API Call
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
            if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                
                self.listOfDesserts = mealData.meals
                               
                self.currentMeal = mealData.meals[0]
                self.currentImageURLString = mealData.meals[0].imageUrlString
                
                self.getDetails(mealId: self.currentMeal!.idMeal)
                
            }
        }

    }
    
    
    //From the ID, get the other information (Ingredients & Instructions)
    func getDetails(mealId: String) {

        let base_url: String = "https://www.themealdb.com/api/json/v1/1/lookup.php?"
        let api_call: String = base_url + "i=" + mealId
        
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: api_call)!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
            if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                               
                //Update the Current Meal and Its Image
                self.currentMeal = mealData.meals.first
                self.currentImageURLString = mealData.meals.first?.imageUrlString
                
    
            }
        }
        
        
    }

}
