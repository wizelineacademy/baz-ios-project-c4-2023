//
//  SearchTableViewController.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var viewModel: SearchViewModel
    var dataSource: SearchViewModel.MediaTableDataSource?
    
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
        self.bindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setSearchController()
        createDataSource()
        loadData()
    }
    
    private func setView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MediaTableViewCell")
    }
    
    private func setSearchController() {
        navigationItem.searchController = searchController
    }
    
    private func loadData() {
        viewModel.loadData()
    }
    
    private func bindings() {
        viewModel.bindSnapshot { [weak self] in
            DispatchQueue.main.async {
                guard let snapshot = self?.viewModel.getSnapshot() else { return }
                self?.dataSource?.apply(snapshot)
            }
        }
    }
    
    private func createDataSource() {
        dataSource = SearchViewModel.MediaTableDataSource(tableView: tableView) { (tableView, indexPath, itemIdentifier) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = itemIdentifier.title
            config.secondaryText = itemIdentifier.mediaType?.itemTitle
            Task {
                config.image = try? await UIImage(download: itemIdentifier.posterPath ?? "")
            }
            cell.contentConfiguration = config
            return cell
        }
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}