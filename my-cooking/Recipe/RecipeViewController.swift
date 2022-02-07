//
//  RecipeViewController.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import UIKit
import AlamofireImage

class RecipeViewController: UIViewController {

    // MAKR: - UI componenets

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var difficultyLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!

    // MARK: - Dependencies

    private let repository = DishesRepository.shared

    // MARK: - State

    var recipe: Recipe!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        display(recipe: recipe)
    }

    private func display(recipe: Recipe) {

        titleLabel.text = recipe.title
        difficultyLabel.text = recipe.dificulty.localizedString
        difficultyLabel.textColor = recipe.dificulty.color
        textLabel.text = recipe.text

        if let imageUrl = recipe.image {
            imageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "placeholder_big"))
        } else {
            imageView.image = UIImage(named: "placeholder_big")
        }
    }

    // MARK: - Actions

    @IBAction func saveAttemptedRecipe(_ sender: UIButton) {
        let alert = UIAlertController(title: NSLocalizedString("save_attempt_sheet_title", comment: ""),
                                      message: NSLocalizedString("save_attempt_sheet_message", comment: ""),
                                      preferredStyle: .actionSheet)
        for result in CookingResult.allCases {
            alert.addAction(UIAlertAction(title: result.localizedString,
                                          style: .default,
                                          handler: { (_) in
                                            self.saveAttempt(with: result)
            }))
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""),
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func saveAttempt(with result: CookingResult) {
        let dish = Dish(id: UUID(), recipe: recipe, result: result)
        repository.save(dish: dish)
    }

}
