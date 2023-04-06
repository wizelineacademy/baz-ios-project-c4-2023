//
//  ReusableTableViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import Foundation
import UIKit

class ReusableTableViewController<T: ReusableTableViewCell<U>, U>: ReusableViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Variables

    var items = [U]()

    var message = ""

    var section = 1

    var height: CGFloat = 50

    let reusableTableView = UITableView()

    // MARK: - Override Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupView()
        configTableView()
    }

    override func setupView() {
        reusableTableView.backgroundColor = .white
        view.addSubview(reusableTableView)
        reusableTableView.dataSource = self
        reusableTableView.delegate = self
        let reuseIdentifier = NSStringFromClass(T.self)
        reusableTableView.register(T.self, forCellReuseIdentifier: reuseIdentifier)
        
        reusableTableView.translatesAutoresizingMaskIntoConstraints = false
        reusableTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        reusableTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        reusableTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        reusableTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: - Publics Functions

    func configTableView() {}

    // MARK: - Protocols Functions

    ///UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    ///UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
}
