//
//  RecipesListViewController.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import UIKit
import AlamofireImage

class RecipesListViewController: UIViewController {

    // MARK: - UI components

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Dependencies

    private let repository = RecipesRepository.shared
    private lazy var datasource: SectionedTableDatasource<Recipe> = {
        let datasource = SectionedTableDatasource<Recipe>()
        datasource.configureCell = { (element, cell) in
            cell.textLabel?.text = element.title
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            cell.detailTextLabel?.text = element.dificulty.localizedString
            cell.detailTextLabel?.textColor = element.dificulty.color
            cell.imageView?.contentMode = .scaleAspectFill
            cell.imageView?.clipsToBounds = true
            if let imageUrl = element.image {
                cell.imageView?.af.setImage(withURL: imageUrl,
                                            placeholderImage: UIImage(named: "placeholder_small"),
                                            filter: AspectScaledToFitSizeFilter(size: CGSize(width: 32, height: 32)))
            } else {
                cell.imageView?.image = UIImage(named: "placeholder_small")
            }
        }
        datasource.didSelectElement = { [weak self] element in
            self?.performSegue(withIdentifier: "ShowDetailsScreen", sender: element)
        }
        return datasource
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.delegate = datasource
        tableView.dataSource = datasource
        loadData()
    }

    private func loadData() {
        repository.sectionedRecipes { [weak self] (result) in
            switch result {
            case .success(let sections):
                self?.datasource.sections = sections
                self?.tableView.reloadData()
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }

    private func handleError(_ error: Error) {
        // There are no errors at the moment, therefore we don't need to implement this method.
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let recipeViewController = segue.destination as? RecipeViewController,
            let recipe = sender as? Recipe {
            recipeViewController.recipe = recipe
        }
    }

    @IBAction func unwindFromRecipeViewController(_ segue: UIStoryboardSegue) {

    }

}
