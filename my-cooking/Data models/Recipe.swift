//
//  Recipe.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import Foundation

struct Recipe: Decodable {

    var id: UUID
    var title: String
    var imageUrl: String?
    var image: URL? {
        guard let imageUrl = imageUrl else {
            return nil
        }
        return URL(string: imageUrl)
    }
    var text: String
    var dificulty: Difficulty

}
