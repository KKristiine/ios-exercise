//
//  Dish.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import Foundation

/// Represnts an attempt to cook a dish.
struct Dish {

    var id: UUID
    var recipe: Recipe
    var result: CookingResult

}
