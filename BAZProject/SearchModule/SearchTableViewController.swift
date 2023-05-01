//
//  SearchTableViewController.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var viewModel: SearchViewModel
    var dataSource: SearchViewModel.MediaCollectionDataSource?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search moves, tv series, people..."
        definesPresentationContext = true
        return searchController
    }()

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
        self.title = "Search"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setSearchController()
    }
    
    private func setSearchController() {
        navigationItem.searchController = searchController
    }
    
}

extension SearchTableViewController: UISearchResultsUpdating {
    
  func updateSearchResults(for searchController: UISearchController) {
      
  }
    
}
