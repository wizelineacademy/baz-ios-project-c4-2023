//
//  RecentView.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

class RecentView: UITableViewController {

    // MARK: Properties
    var presenter: RecentPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RecentView: RecentViewProtocol {
    // TODO: implement view output methods
}
