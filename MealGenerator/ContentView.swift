//
//  ContentView.swift
//  MealGenerator
//
//  Created by Vinodh Sekhar on 5/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var mealGenerator = MealGenerator()
    
    var actionButton: some View {
        Button("Get Random Meal") {
            mealGenerator.fetchRandommeal()
            
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(16)
        .onAppear {
            mealGenerator.fetchRandommeal()
        }
    }
    
    var dessertButton: some View {
        Button("Get Dessert") {
            mealGenerator.fetchDessert()
            
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(16)
        .onAppear {
            mealGenerator.fetchDessert()
        }
    }
    
  
    
    var body: some View {
        ScrollView {
            VStack {
                dessertButton
                actionButton
                if let name = mealGenerator.currentMeal?.name {
                    Text(name)
                        .font(.largeTitle)
                }
                AsyncImageView(urlString: $mealGenerator.currentImageURLString)
                
                if let ingredients = mealGenerator.currentMeal?.ingredients {
                    HStack {
                        
                        Text("Ingredients")
                            .font(.title2)
                        Spacer()
                    }
                    
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            
                            Text(ingredient.name + " - " + ingredient.measure)
                            Spacer()
                        }
                    }
                    
                }
                if let instructions = mealGenerator.currentMeal?.instructions {
                    HStack {
                        Text("Instructions")
                            .font(.title2)
                            Spacer()
                    }
                    Text(instructions)
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
