//
//  ContentView.swift
//  MealGenerator
//
//  Created by Vinodh Sekhar on 5/20/23.
//

import SwiftUI

struct ContentView: View {
    
    //Meal Generator Object
    @StateObject private var mealGenerator = MealGenerator()
    
    
    var body: some View {
            NavigationView {
                VStack{
                    List {
                        ForEach(mealGenerator.listOfDesserts, id : \.self) {dessert in
                            
                            @State var myMeal: Meal? = dessert
                        
                            NavigationLink(destination: ingredientView(currentMeal: $myMeal)) {
                                
                                Text(dessert.name)
                                
                                
                            }.padding()
                            
                        }
                        .navigationTitle("Desserts")
                    }
                    Spacer()
                  
                } .frame(maxHeight: .infinity)
                
             
        }.onAppear {
            mealGenerator.getDesserts()

        }
            
    }
}


//Transition View
struct ingredientView: View  {
    
    @Binding var currentMeal: Meal?
    @StateObject private var mealGenerator = MealGenerator()
    
    
    var body: some View {
        ScrollView {
            VStack {
                
                if let name = currentMeal?.name {
                    Text(name)
                        .font(.largeTitle)
                }
               
                AsyncImageView(urlString: $mealGenerator.currentImageURLString)
                
                //Populate Ingredients
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
                
                //Populate Instructions
                if let instructions = mealGenerator.currentMeal?.instructions {
                    HStack {
                        Text("Instructions")
                            .font(.title2)
                        Spacer()
                    }
                    Text(instructions)
                }
            }.padding()
        }.onAppear {
            
            //Get the full information for the meal
            mealGenerator.getDetails(mealId: currentMeal!.idMeal)
            
            
        }
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
