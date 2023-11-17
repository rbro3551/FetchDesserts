//
//  ContentView.swift
//  FetchDesserts
//
//  Created by Riley Brookins on 11/7/23.
//

import SwiftUI

struct DessertsView: View {
    @StateObject var vm = DessertsViewModel(networkManager: NetworkingManager())
    
    var body: some View {
        /* Using a NavigationView since a NavigationStack causes weird list behavior in that
        it seems to offset itself a bit when clicking on a navigation link */
        NavigationView {
            List(vm.filteredMeals, id: \.idMeal) { meal in
                NavigationLink {
                    MealDetailsView(id: meal.idMeal)
                        .navigationTitle("\(meal.strMeal)")
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            } else {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        Text(meal.strMeal)
                    }
                    
                    
                }
            }
            .listStyle(.plain)
            .searchable(text: $vm.searchText, prompt: "Search for a dessert")
            .navigationTitle("FetchDesserts")
        }
        .onAppear {
            Task {
                await vm.getMeals()
                vm.addSubscribers()
            }
        }
        
    }
}

#Preview {
    DessertsView()
}
