//
//  RecommendationRepository.swift
//  my-cooking
//
//  Created by Kristīne Kazakēviča on 07/02/2022.
//  Copyright © 2022 ito. All rights reserved.
//

import Foundation

class RecommendationRepository {

    static let shared: RecommendationRepository = RecommendationRepository()

    private let recipesRepository = RecipesRepository.shared
    private let dishesRepository = DishesRepository.shared

    // MARK: - Access

    /// Loads the recommended recipe.
    ///
    /// - Parameter completion: A callback that is called when loading is finished.
    func getRecommendation(completion: LoadCallback<Recipe?>) {
        dishesRepository.allDishes { [weak self] result in
            switch result {
            case .success(let dishes):
                self?.loadRecipes(dishes: dishes, completion: completion)
            default:
                break
            }
        }
    }

    /// Loads all available recipes.
    ///
    /// - Parameter dishes: An array of loaded dishes.
    /// - Parameter completion: A callback that is called when loading is finished.
    private func loadRecipes(dishes: [Dish], completion: LoadCallback<Recipe?>) {
        recipesRepository.allRecipes { [weak self] result in
            switch result {
            case .success(let recipes):
                self?.chooseRecommendation(dishes: dishes, recipes: recipes, completion: completion)
            default:
                break
            }
        }
    }

    /// Chooses the most suitable recipe.
    ///
    /// - Parameter dishes: An array of loaded dishes.
    /// - Parameter recipes: An array of loaded recipes.
    /// - Parameter completion: A callback that is called when loading is finished.
    private func chooseRecommendation(dishes: [Dish], recipes: [Recipe], completion: LoadCallback<Recipe?>) {

        // If there are no tried recipes, the function returns an easy recipe.
        guard !dishes.isEmpty else {
            completion(.success(recipes.filter { $0.dificulty == .easy }.randomElement()))
            return
        }

        let triedRecipes = dishes.map { $0.recipe }

        let untriedEasyRecipes = recipes.filter{ $0.dificulty == .easy }.filter { !triedRecipes.contains($0) }
        let untriedNormalRecipes = recipes.filter{ $0.dificulty == .normal }.filter { !triedRecipes.contains($0) }
        let untriedHardRecipes = recipes.filter{ $0.dificulty == .hard }.filter { !triedRecipes.contains($0) }

        // Calculates the rating of each tried recipe according to the level of difficulty.
        // If all recipes for a given level of difficulty have been tried, the rating is 0, because it is no longer relevant.
        let easyRating = untriedEasyRecipes.isEmpty ? 0 : dishes
            .filter { $0.recipe.dificulty == .easy }.map { $0.result.rating }.reduce(0, +)
        let normalRating = untriedNormalRecipes.isEmpty ? 0 : dishes
            .filter { $0.recipe.dificulty == .normal }.map { $0.result.rating }.reduce(0, +)
        let hardRating = untriedHardRecipes.isEmpty ? 0 : dishes
            .filter { $0.recipe.dificulty == .hard }.map { $0.result.rating }.reduce(0, +)

        // Selects the recipe from the level of difficulty with the higher rating.
        let recipe: Recipe?
        if easyRating >= normalRating && easyRating >= hardRating && !untriedEasyRecipes.isEmpty {
            recipe = untriedEasyRecipes.randomElement()
        } else if normalRating >= hardRating && !untriedNormalRecipes.isEmpty {
            recipe = untriedNormalRecipes.randomElement()
        } else {
            recipe = untriedHardRecipes.randomElement()
        }

        completion(.success(recipe))
    }
}
