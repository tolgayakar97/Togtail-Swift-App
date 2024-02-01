//
//  LetterResult.swift
//  togtail
//
//  Created by Tolga Yakar on 24.01.2024.
//
struct DrinksModel: Codable {
    var drinks: [Drinks]
}

struct Drinks : Codable {
    
    var ingredients: [String?] {
        
        //Computed prop for getting ingredients and remove nil ones.
        var ingredientList = [strIngredient1,strIngredient2,strIngredient3,strIngredient4,strIngredient5,strIngredient6,strIngredient7,strIngredient8,strIngredient9,strIngredient10]
        
        //strIngredients(N) can be null.
        //nil elements removed from the list
        ingredientList.removeAll { x in
            x == nil
        }
        
        return ingredientList
    }
    
    let strDrink: String?
    
    let strInstructions: String?
    let strDrinkThumb: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
}
