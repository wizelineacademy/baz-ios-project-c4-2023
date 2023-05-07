//
//  FavoritesViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 18/04/23.
//

import UIKit

final class FavoritesViewController: MasterMovieTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the navigation bar
        configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor(named: "background") ?? .white, tintColor: .white, title: "Favorite Movies", preferredLargeTitle: true)
        
        self.setupViewModel(MovieListViewModel(.favorites))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MovieListLocal().getMovies() { [weak self] movieList in
            self?.viewModel?.setMovies(movieList.results)
        }
    }
}

extension FavoritesViewController: MasterMovieTableViewProtocols {
    
    /// Sets up the view model for the movies view controller.
    /// - Parameters:
    ///     - viewModel: The view model to be set up for the movies view controller.
    func setupViewModel(_ viewModel: MovieListViewModel) {
        viewModel.delegate = self
        self.viewModel = viewModel
    }
}

extension FavoritesViewController: MovieListViewModelProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}
