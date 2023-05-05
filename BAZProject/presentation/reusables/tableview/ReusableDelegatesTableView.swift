//
//  ReusableDelegatesTableView.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 17/04/23.
//

import Foundation
import UIKit

class ReusableTableViewDataSource<T: ReusableTableViewCell<U>, U>: NSObject, UITableViewDataSource {

    // MARK: - Variables

    var items: [U] = []
    var message = ""
    var section = 1

    func updateItems(_ items: [U]) {
        self.items = items
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.count == 0 {
            tableView.setEmptyMessage(message)
        } else {
            tableView.restore()
        }
        return items.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = NSStringFromClass(T.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else { return UITableViewCell() }
        cell.item = items[indexPath.row]
        return cell
    }
}

class ReusableTableViewDelegate: NSObject, UITableViewDelegate {

    var height: CGFloat = 100

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
}
