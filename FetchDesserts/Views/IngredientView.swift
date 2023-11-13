//
//  IngredientView.swift
//  FetchDesserts
//
//  Created by Riley Brookins on 11/8/23.
//

import SwiftUI

struct IngredientView: View {
    let ingredients: [Ingredient]
    
    var body: some View {
        List(ingredients, id: \.id) { ingredient in
            // Checking for blank values
            if ingredient.ingredient != "" {
                Text("\(ingredient.measure) \(ingredient.ingredient)")
            }
        }
    }
}

#Preview {
    IngredientView(ingredients: [])
}
