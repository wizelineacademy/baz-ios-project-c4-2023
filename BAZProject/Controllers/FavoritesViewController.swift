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
        
        setupViewModel(MovieListViewModel(.popular))
        setupView()
        applyFilter()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - Methods

extension FavoritesViewController {
    
    func setupView() {
        
    }
    
    func applyFilter(_ filterType: Enum_MovieFilters? = nil) {
        viewModel?.applyFilter(filterType) { [weak self] in
            self?.navigationItem.title = self?.viewModel?.getTitle()
            self?.tableView.reloadData()
        }
    }
}

extension FavoritesViewController: MasterMovieTableViewProtocols {
    
    func setupViewModel(_ viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
}

