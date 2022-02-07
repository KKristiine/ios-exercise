//
//  Difficulty.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import UIKit

/// Represents recipe difficulty.
enum Difficulty: String, Decodable, CaseIterable {

    case easy
    case normal
    case hard

}

extension Difficulty {

    /// Returns a color that represents this diffculty.
    var color: UIColor {
        switch self {
        case .easy:
            return UIColor.systemGreen
        case .normal:
            return UIColor.systemOrange
        case .hard:
            return UIColor.systemRed
        }
    }

    /// Returns a localized string representation for the difficulty, that can be displayed to the user.
    var localizedString: String {
        return NSLocalizedString(rawValue, comment: "")
    }

}
