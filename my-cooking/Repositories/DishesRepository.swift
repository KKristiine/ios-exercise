//
//  DishesRepository.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import Foundation

class DishesRepository {

    static let shared: DishesRepository = DishesRepository()

    // MAKR: - State

    private var dishes: [Dish] = []

    // MARK: - Init

    init() {
        // TODO: Add some test data maybe?
    }

    // MARK: - Access

    /// Loads all available dishes.
    ///
    /// - Parameter completion: A callback that is called when loading is finished.
    func allDishes(completion: LoadCallback<[Dish]>) {
        completion(.success(dishes))
    }

    /// Loads an array of dishes with specified cooking result.
    ///
    /// - Parameters:
    ///   - result: Specifies cooking result for the dishes to load.
    ///   - completion: A callback that is called when loading is finished.
    func dishes(withResult result: CookingResult, completion: LoadCallback<[Dish]>) {
        let result = dishes.filter { $0.result == result }
        completion(.success(result))
    }

    /// Loads a dish with specified id.
    ///
    /// - Parameters:
    ///   - id: Specifies the id of the dish to load.
    ///   - completion: A callback that is called when loading is finished.
    func dish(withId id: UUID, completion: LoadCallback<Dish>) {
        guard let result = dishes.first(where: { $0.id == id }) else {
            completion(.failure(AppError.invalidId))
            return
        }

        completion(.success(result))
    }

    /// Stores a recipe in repository.
    ///
    /// - Parameter recipe: A dish to save.
    func save(dish: Dish) {
        dishes.append(dish)
    }
}
