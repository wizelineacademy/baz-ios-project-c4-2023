//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 18/04/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieVM: MovieViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor(named: "background") ?? .white, tintColor: .white, title: movieVM?.title ?? "Detail", preferredLargeTitle: true)
    }
}
