//
//  UpcomingView.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

class UpcomingView: UITableViewController {

    // MARK: Properties
    var presenter: UpcomingPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UpcomingView: UpcomingViewProtocol {
    // TODO: implement view output methods
}
