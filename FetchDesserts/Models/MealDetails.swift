//
//  MealDetails.swift
//  FetchDesserts
//
//  Created by Riley Brookins on 11/7/23.
//

import Foundation


struct MealDetailsResponse: Decodable {
    let meals: [MealDetails]
}

struct MealDetails: Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String?
    let strMealThumb: String?
    let strYoutube: String?
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        // Defining coding keys
        case idMeal, strMeal, strDrinkAlternate, strCategory, strArea, strInstructions, strMealThumb, strTags, strYoutube
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Properties
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        self.strMealThumb = try container.decodeIfPresent(String.self, forKey: .strMealThumb)
        self.strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)

        // Iterating over the ingredient/measure keys and decoding/unwrapping the ingredients into a seperate model
        var ingredients: [Ingredient] = []
        for index in 1...20 {
            let ingredientKey = "strIngredient\(index)"
            let measureKey = "strMeasure\(index)"
            
            if let ingredient = try container.decodeIfPresent(String.self, forKey: CodingKeys(stringValue: ingredientKey) ?? .strMeal),
               let measure = try container.decodeIfPresent(String.self, forKey: CodingKeys(stringValue: measureKey) ?? .strMeal) {
                let ingredientModel = Ingredient(ingredient: ingredient, measure: measure)
                ingredients.append(ingredientModel)
            }
        }
        self.ingredients = ingredients
    }
}

struct Ingredient: Codable, Identifiable {
    var id = UUID()
    let ingredient: String
    let measure: String
}
