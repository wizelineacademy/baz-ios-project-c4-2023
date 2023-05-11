//
//  FavoritesViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 18/04/23.
//

import UIKit

final class FavoritesViewController: MasterMovieTableViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the navigation bar
        configureNavigationBar(largeTitleColor: .white, backgoundColor: UIColor(named: "background") ?? .white, tintColor: .white, title: "Favorite Movies", preferredLargeTitle: true)
        
        self.setupViewModel(MovieListViewModel(.favorites))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.updateIfNecesary()
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

/// This extension implements the MovieListViewModelProtocol protocol for the FavoritesViewController class.
/// It provides a method to reload data in the table view.
extension FavoritesViewController: MovieListViewModelProtocol {
    /// Reloads data in the table view.
    func reloadData() {
        tableView.reloadData()
    }
}
