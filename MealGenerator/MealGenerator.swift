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
    func fetchRandommeal() {
        
        //API Call
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
            if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                
                self.listOfDesserts = mealData.meals
                               
                self.currentMeal = mealData.meals[1]
                self.currentImageURLString = mealData.meals[1].imageUrlString
                
                self.getDetails(mealId: self.currentMeal!.idMeal)
                
            }
        }

    }
    
    
    //Given The Meal Data, Look up Extra Information
    func getDetails(mealId: String) {

        var baseURL: String = "https://www.themealdb.com/api/json/v1/1/lookup.php?"
        var APICall: String = baseURL + "i=" + mealId
        
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: APICall)!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
            if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                               
                //Update the Current Meal and Its Image
                self.currentMeal = mealData.meals.first
                self.currentImageURLString = mealData.meals.first?.imageUrlString
                
    
            }
        }
        
        
    }
    
    private var dcancellable: AnyCancellable?
    
    //Fetching the Dessert
    @Published var currentDessert: Meal?
    @Published var currentDesertImage: String?
    
    func fetchDessert() {
                
        dcancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { dataOne, _ in
             
            if let mealData = try? JSONDecoder().decode(MealData.self, from: dataOne) {
                
                self.currentDessert = mealData.meals.first
                self.currentDesertImage = mealData.meals.first?.imageUrlString
                    
                
            }
        }
        
        
    }
    
    
}
