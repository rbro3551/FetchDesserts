//
//  DessertsViewModel.swift
//  FetchDesserts
//
//  Created by Riley Brookins on 11/7/23.
//

import Foundation
import Combine

class DessertsViewModel: ObservableObject {
    let networkManager = NetworkingManager()
    @Published var meals: [Meal] = []
    @Published var filteredMeals: [Meal] = []
    @Published var searchText = ""
    private var cancellables = Set<AnyCancellable>()
    
    
    func addSubscribers() {
        $searchText
            .combineLatest($meals)
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map { (searchText, meals) -> [Meal] in
                // Sorting meals alphabetically based on the search text
                guard !searchText.isEmpty else {
                    return meals.sorted()
                }
                return meals.sorted().filter { $0.strMeal.localizedCaseInsensitiveContains(searchText) }
            }
            .sink { [weak self] (filterList) in
                self?.filteredMeals = filterList
            }
            .store(in: &cancellables)
    }
    
    // Fetch meal data using the network manager
    func getMeals() async {
        // Fetching initial list of desserts from provided url
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        Task { @MainActor in
            do {
                let data = try await networkManager.download(url: url)
                let mealsDict = try JSONDecoder().decode(Meals.self, from: data)
                meals = mealsDict.meals
            } catch {
                print("Error fetching data \(error)")
                meals = []
            }
        }
        
    }
    
    func filteredMeals(meals: [Meal]) -> [Meal] {
        // Filtering dessert array alphabetically based on the searchText
        if !searchText.isEmpty {
            return meals.sorted().filter { $0.strMeal.localizedCaseInsensitiveContains(searchText) }
        } else {
            return meals.sorted()
        }
    }
}
