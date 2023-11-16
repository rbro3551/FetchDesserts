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
}

struct Ingredient: Codable, Identifiable {
    var id = UUID()
    let ingredient: String
    let measure: String
}

extension MealDetails {
    init(from decoder: Decoder) throws {
        // Custom decoding for ingredients
        let container = try decoder.singleValueContainer()
        let mealDict = try container.decode([String: String?].self)
        var index = 1
        var ingredients: [Ingredient] = []
        while let ingredient = mealDict["strIngredient\(index)"] as? String,
              let measure = mealDict["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(Ingredient(ingredient: ingredient, measure: measure))
            index += 1
        }
            self.ingredients = ingredients
            // decoding the rest of the values
            idMeal = mealDict["idMeal"] as? String ?? ""
            strMeal = mealDict["strMeal"] as? String ?? ""
            strInstructions = mealDict["strInstructions"] as? String ?? ""
            strMealThumb = mealDict["strMealThumb"] as? String ?? ""
            strYoutube = mealDict["strYoutube"] as? String ?? ""
        }
    }
