//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by 989438 on 29/03/23.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = NSLocalizedString(MainLocalizableString.detailScreenTitle.rawValue, comment: "")
    }
}
