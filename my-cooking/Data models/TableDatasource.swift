//
//  TableDatasource.swift
//  my-cooking
//
//  Created by Vladas Drejeris on 16/09/2019.
//  Copyright © 2019 ito. All rights reserved.
//

import UIKit

class TableDatasource<Element>: NSObject, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Dependencies

    var configureCell: (Element, UITableViewCell) -> Void = { _, _ in }
    var didSelectElement: (Element) -> Void = { _ in }

    // MARK: - State

    var elements: [Element] = []

    // MAKR: - UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let cellIdentifier = "RecipeCell"
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = reusableCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }

        let element = elements[indexPath.row]
        configureCell(element, cell)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let element = elements[indexPath.row]
        didSelectElement(element)
    }

}
