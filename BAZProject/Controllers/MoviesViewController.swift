//
//  MoviesViewController.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit

final class MoviesViewController: MasterMovieTableViewController {
    
    @IBOutlet weak var btnFilter: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel(MovieListViewModel(.trending))
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

extension MoviesViewController {
    
    func setupView() {
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Treanding",   handler: { [weak self] _ in self?.applyFilter(.trending)   }),
                UIAction(title: "Now Playing", handler: { [weak self] _ in self?.applyFilter(.nowPlaying) }),
                UIAction(title: "Popular",     handler: { [weak self] _ in self?.applyFilter(.popular)    }),
                UIAction(title: "Top Rated",   handler: { [weak self] _ in self?.applyFilter(.topRated)   }),
                UIAction(title: "Upcoming",    handler: { [weak self] _ in self?.applyFilter(.upcoming)   })
            ]
        }

        btnFilter.menu = UIMenu(title: "Filter", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    func applyFilter(_ filterType: Enum_MovieFilters? = nil) {
        viewModel?.applyFilter(filterType) { [weak self] in
            self?.navigationItem.title = self?.viewModel?.getTitle()
            self?.tableView.reloadData()
        }
    }
}

extension MoviesViewController: MasterMovieTableViewProtocols {
    
    func setupViewModel(_ viewModel: MovieListViewModel) {
        self.viewModel = viewModel
    }
}
