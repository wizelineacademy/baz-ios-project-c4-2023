//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 15/04/23.
//

import UIKit

// MARK: - Class
class SearchViewController: ReusableViewController {

    private let searchMovieItemAdapterIdentifier = NSStringFromClass(SearchMovieItemAdapter.self)
    private let simpleItemAdapterIdentifier = NSStringFromClass(SimpleItemAdapter.self)
    private var searchViewModel: SearchViewModel?
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var searchTask: DispatchWorkItem?

    override func setupView() {
        super.setupView()
        setupSearchController()
        configTableView()
        setupActivityIndicator()
        let repository = SearchDataSourceRemote()
        searchViewModel = SearchViewModel(repository)
        searchViewModel?.delegate = self
    }
    
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "searchQuestionText".localized
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

    }
    
    func configTableView() {
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SearchMovieItemAdapter.self, forCellReuseIdentifier: searchMovieItemAdapterIdentifier)
        tableView.register(SimpleItemAdapter.self, forCellReuseIdentifier: simpleItemAdapterIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func updateTable() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

// MARK: - Extensions
extension SearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        // El controlador de búsqueda se presentó en la interfaz de usuario
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        if query.isEmpty {
            searchViewModel?.sectionTitles = []
            updateTable()
        } else {
            activityIndicator.startAnimating()
            searchTask?.cancel()
            let task = DispatchWorkItem { [weak self] in
                self?.searchViewModel?.fetchSearch(query)
            }
            searchTask = task
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: task)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return searchViewModel?.sectionTitles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return searchViewModel?.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = searchViewModel?.sectionTitles[section]
        switch section {
        case "moviesText".localized :
            return searchViewModel?.movies.count ?? 0
        case "otherSuggestionsText".localized :
            return searchViewModel?.keywords.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = searchViewModel?.sectionTitles[indexPath.section]
        switch section {
        case "moviesText".localized :
            if let movieCell = tableView.dequeueReusableCell(withIdentifier: searchMovieItemAdapterIdentifier, for: indexPath) as? SearchMovieItemAdapter {
                movieCell.item = searchViewModel?.movies[indexPath.row]
                return movieCell
            }
            return UITableViewCell()
        case "otherSuggestionsText".localized :
            if let simpleCell = tableView.dequeueReusableCell(withIdentifier: simpleItemAdapterIdentifier, for: indexPath) as? SimpleItemAdapter {
                simpleCell.item = searchViewModel?.keywords[indexPath.row]
                return simpleCell
            }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = searchViewModel?.sectionTitles[indexPath.section]
        switch section {
        case "moviesText".localized :
            return .dim100
        case "otherSuggestionsText".localized :
            return .dim32
        default:
            return 44
        }
    }
}

extension SearchViewController: SearchDelegate {
    func searchResults() {
        self.updateTable()
    }
}
