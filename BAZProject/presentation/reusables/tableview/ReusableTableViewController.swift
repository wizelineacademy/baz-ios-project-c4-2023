//
//  ReusableTableViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 17/04/23.
//

import Foundation
import UIKit

class ReusableTableViewController<T: ReusableTableViewCell<U>, U>: ReusableViewController {

    // MARK: - Variables
    var reusableDataSource = ReusableTableViewDataSource<T, U>()
    var reusableDelegateAndFlowLayout = ReusableTableViewDelegate()

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
        reusableTableView.dataSource = reusableDataSource
        reusableTableView.delegate = reusableDelegateAndFlowLayout
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
}
