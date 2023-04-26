//
//  MoviesViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit

final class MoviesViewController: MasterMovieTableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var btnFilter: UIBarButtonItem!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel(MovieListViewModel(.trending))
        setupView()
        applyFilter()
    }
}

// MARK: - Methods

extension MoviesViewController {
    
    /**
     Sets up the view by creating a menu of filter options and assigning it to a button.

     - Returns: Void.
    */
    private func setupView() -> Void {
        /**
         Creates an array of `UIAction` items representing different filter options.
         The `handler` closure of each item applies a filter to the view controller.
        */
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Treanding",   handler: { [weak self] _ in self?.applyFilter(.trending)   }),
                UIAction(title: "Now Playing", handler: { [weak self] _ in self?.applyFilter(.nowPlaying) }),
                UIAction(title: "Popular",     handler: { [weak self] _ in self?.applyFilter(.popular)    }),
                UIAction(title: "Top Rated",   handler: { [weak self] _ in self?.applyFilter(.topRated)   }),
                UIAction(title: "Upcoming",    handler: { [weak self] _ in self?.applyFilter(.upcoming)   })
            ]
        }
        
        // Creates a menu from the array of `UIAction` items and assigns it to the `btnFilter` button.
        btnFilter.menu = UIMenu(title: "Filter", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    /**
     Applies the specified filter to the movie view model and updates the table view with the filtered data.

     - parameter filterType: An optional `Enum_MovieFilters` value representing the type of filter to apply. If this parameter is `nil`, all filters will be removed.
     */
    private func applyFilter(_ filterType: MovieFilter? = nil) {
        viewModel?.applyMovieFilter(filterType) { [weak self] in
            self?.navigationItem.title = self?.viewModel?.getTitle()
            self?.tableView.reloadData()
        }
    }
}

extension MoviesViewController: MasterMovieTableViewProtocols {
    
    /**
     Sets up the view model for the movies view controller.

     - Parameters:
         - viewModel: The view model to be set up for the movies view controller.
     */
    func setupViewModel(_ viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
}
