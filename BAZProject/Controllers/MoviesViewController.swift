//
//  MoviesViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit

final class MoviesViewController: MasterMovieTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(MovieListViewModel(.trending))
    }
}

// MARK: - Methods

extension MoviesViewController {
    
    
    /**
     Configures the view controller by loading trending movies for the day and populating the table view with the results.
    */
//    private func setup() {
//
//
//
//    }
    
}

extension MoviesViewController: MasterMovieTableViewProtocols {
    func setup(_ viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        
        viewModel.filter() { [weak self] in
            self?.navigationItem.title = viewModel.getTitle()
            self?.tableView.reloadData()
        }
    }
    
    
    
}
