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
    var dispatchService: DispatchProtocol = DispatchQueue.main
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
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
        bindings()
        setView()
        setSearchController()
        createDataSource()
        loadData()
    }
    
    private func setView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
    }
    
    private func setSearchController() {
        navigationItem.searchController = searchController
    }
    
    private func loadData() {
        viewModel.loadData()
    }
    
    private func bindings() {
        viewModel.bindSnapshot { [weak self] in
            self?.dispatchService.async {
                guard let snapshot = self?.viewModel.getSnapshot() else { return }
                self?.dataSource?.apply(snapshot)
            }
        }
    }
    
    private func createDataSource() {
        dataSource = SearchViewModel.MediaTableDataSource(tableView: tableView) { [weak self] (tableView, indexPath, itemIdentifier) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as? MediaTableViewCell, let model = self?.viewModel.getCellModel(for: itemIdentifier) else { return UITableViewCell() }
            cell.setCell(with: model)
            return cell
        }
        
    }
}

extension SearchTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        dispatchService.asyncAfter(deadline: .now() + 0.8) {
            if let searchText = searchController.searchBar.text, searchText != "" {
                self.viewModel.searchMedia(keyword: searchText)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadData()
    }
    
}

extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * 0.25
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionTitle = viewModel.getSectionTitle(for: section) else { return nil }
        let label = UILabel()
        label.text = sectionTitle
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.getSectionTitle(for: section) == nil ? 0 : UITableView.automaticDimension
    }
    
}
