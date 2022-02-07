//
//  CookingResult.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import Foundation

/// Represents the result of cooking a dish.
enum CookingResult: String, CaseIterable {

    /// User was unable to prepare the dish correctly.
    case totalDisaster

    /// User prepared the dish, but it was not completely successful.
    case itWasEdible

    /// User prepared the dish perfectly.
    case perfection
}

extension CookingResult {

    /// Returns a localized string representation for the result, that can be displayed to the user.
    var localizedString: String {
        return NSLocalizedString(rawValue, comment: "")
    }

    var rating: Int {
        switch self {
        case .totalDisaster:
            return 1
        case .itWasEdible:
            return 2
        case .perfection:
            return 3
        }
    }

}
