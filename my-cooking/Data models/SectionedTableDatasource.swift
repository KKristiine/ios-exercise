//
//  SectionedTableDatasource.swift
//  my-cooking
//
//  Created by Kristīne Kazakēviča on 07/02/2022.
//  Copyright © 2022 ito. All rights reserved.
//

import UIKit

class SectionedTableDatasource<Element>: NSObject, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Dependencies

    var configureCell: (Element, UITableViewCell) -> Void = { _, _ in }
    var didSelectElement: (Element) -> Void = { _ in }

    // MARK: - State

    var sections: [TableSection<Element>] = []

    // MAKR: - UITableViewDelegate, UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let cellIdentifier = "RecipeCell"
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = reusableCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }

        let element = sections[indexPath.section].elements[indexPath.row]
        configureCell(element, cell)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let element = sections[indexPath.section].elements[indexPath.row]
        didSelectElement(element)
    }

}
