//
//  MealGenerator.swift
//  MealGenerator
//
//  Created by Vinodh Sekhar on 5/20/23.
//

import Foundation
import Combine

final class MealGenerator: ObservableObject {
    
    
    
    @Published var currentMeal: Meal?
    @Published var currentImageURLString: String?
    
    public var listOfDesserts = [Meal]()

    
    private var cancellable: AnyCancellable?
    
    func fetchRandommeal() {
        
        //print("Entered the fetch Random Meal Function")

        
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
            if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                
                self.listOfDesserts = mealData.meals
                               
                print(mealData.meals.count)
                
                self.currentMeal = mealData.meals[1]
                self.currentImageURLString = mealData.meals[1].imageUrlString
                
                print(self.currentMeal?.idMeal)
                
                self.getDetails(mealId: self.currentMeal!.idMeal)
                
            }
        }

    }
    
    func getDetails(mealId: String) {

        var baseURL: String
        var APICall: String
        
        baseURL = "https://www.themealdb.com/api/json/v1/1/lookup.php?"
        
        APICall = baseURL + "i=" + mealId
        
        print(APICall)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: URL(string: APICall)!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { data, _ in
            if let mealData = try? JSONDecoder().decode(MealData.self, from: data) {
                               
                print(mealData.meals.count)
                
                self.currentMeal = mealData.meals.first
                self.currentImageURLString = mealData.meals.first?.imageUrlString
                
                //print(self.currentMeal?.ingredients)
                
                //self.getDetails(mealId: self.currentMeal!.idMeal)
                
            }
        }
        
        
    }
    
    private var dcancellable: AnyCancellable?
    
    
    //Fetching tehe Dessert
    @Published var currentDessert: Meal?
    @Published var currentDesertImage: String?
    
    func fetchDessert() {
        
        //print("Hello, we called the fetch dessert function")
        
        dcancellable = URLSession.shared.dataTaskPublisher(for: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { dataOne, _ in
                //print(dataOne)
            if let mealData = try? JSONDecoder().decode(MealData.self, from: dataOne) {
                
                //print("In the tool")
                //print(mealData.meals)
                
                self.currentDessert = mealData.meals.first
                self.currentDesertImage = mealData.meals.first?.imageUrlString
                
                //print(self.currentDessert)
                //print(self.currentDesertImage)
                
            }
        }
        
        //print (self.currentDessert?.id)
        //print(self.currentDesertImage)
        
        
        
        
    }
    
    
}
