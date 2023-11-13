//
//  Meal.swift
//  FetchDesserts
//
//  Created by Riley Brookins on 11/7/23.
//

import Foundation


struct Meals: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Comparable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    static func <(lhs: Meal, rhs: Meal) -> Bool {
        lhs.strMeal < rhs.strMeal
    }
}
