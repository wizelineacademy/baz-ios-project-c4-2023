//
//  ReusableTableViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import Foundation
import UIKit

class ReusableTableViewController<T: ReusableTableViewCell<U>, U>: ReusableViewController,  UITableViewDataSource,UITableViewDelegate{

    var items = [U]()

    var message = ""

    var section = 1

    var height:CGFloat = 50

    let table_view = UITableView()

    func configTableView(){}

    override func viewDidLoad() {
        super.viewDidLoad()
        super.setupView()
        configTableView()
    }

    override func setupView() {
        table_view.backgroundColor = .white
        view.addSubview(table_view)
        table_view.dataSource = self
        table_view.delegate = self
        let reuseIdentifier = NSStringFromClass(T.self)
        table_view.register(T.self, forCellReuseIdentifier: reuseIdentifier)
        
        table_view.translatesAutoresizingMaskIntoConstraints = false
        table_view.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        table_view.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        table_view.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        table_view.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = NSStringFromClass(T.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
        cell.item = items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return height
    }
}
