//
//  RecipesRepository.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import Foundation

typealias LoadCallback<T> = (Result<T, Error>) -> Void

class RecipesRepository {

    static let shared: RecipesRepository = RecipesRepository()

    // MAKR: - State

    private var recipes: [Recipe] = []

    // MARK: - Init

    init() {
        guard let url = Bundle.main.url(forResource: "Recipes", withExtension: "plist") else {
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            return
        }

        do {
            recipes = try PropertyListDecoder().decode([Recipe].self, from: data)
        } catch {
            print(error)
            return
        }
    }

    // MARK: - Access

    /// Loads all available recipes.
    ///
    /// - Parameter completion: A callback that is called when loading is finished.
    func allRecipes(completion: LoadCallback<[Recipe]>) {
        completion(.success(recipes))
    }

    /// Loads an array of recipes with specified difficulty.
    ///
    /// - Parameters:
    ///   - difficulty: Specifies difficulty for the recipes to load.
    ///   - completion: A callback that is called when loading is finished.
    func recipes(withDifficulty difficulty: Difficulty, completion: LoadCallback<[Recipe]>) {
        let result = recipes.filter { $0.dificulty == difficulty }
        completion(.success(result))
    }

    /// Loads a recipe with specified id.
    ///
    /// - Parameters:
    ///   - id: Specifies the id of the recipe to load.
    ///   - completion: A callback that is called when loading is finished.
    func recipe(withId id: UUID, completion: LoadCallback<Recipe>) {
        guard let result = recipes.first(where: { $0.id == id }) else {
            completion(.failure(AppError.invalidId))
            return
        }

        completion(.success(result))
    }

}
