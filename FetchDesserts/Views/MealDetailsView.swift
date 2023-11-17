//
//  MealDetailsView.swift
//  FetchDesserts
//
//  Created by Riley Brookins on 11/7/23.
//

import SwiftUI

struct MealDetailsView: View {
    @StateObject var vm = MealDetailsViewModel(networkManager: NetworkingManager())
    @State private var isShowingIngredients: Bool = false
    let id: String
    
    var body: some View {
        VStack {
            if !vm.mealDetails.isEmpty {
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: vm.mealDetails[0].strMealThumb ?? "")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            } else {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        }
                        .padding(.top)
                        
                        VStack {
                            Button {
                                isShowingIngredients.toggle()
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 200, height: 50)
                                        .foregroundStyle(.ultraThinMaterial)
                                    Text("Show Ingredients")
                                }
                            }
                            
                            
                            if let url = vm.mealDetails[0].strYoutube, let destination = URL(string: url) {
                                Link(destination: destination) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 200, height: 50)
                                            .foregroundStyle(.ultraThinMaterial)
                                        HStack {
                                            Text("Video Instructions")
                                            Image(systemName: "link")
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                        
                        Section {
                            Text("\(vm.mealDetails[0].strInstructions ?? "")")
                                .padding(.horizontal, 10)
                        } header: {
                            VStack {
                                Text("Instructions")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.secondary)
                                Divider()
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            } else {
                ProgressView()
            }

        }
        .sheet(isPresented: $isShowingIngredients) {
            IngredientView(ingredients: vm.mealDetails[0].ingredients)
        }
        .onAppear {
            Task {
                await vm.getMealDetails(mealId: id)
            }
        }
    }
}

#Preview {
    MealDetailsView(id: "52917")
}
