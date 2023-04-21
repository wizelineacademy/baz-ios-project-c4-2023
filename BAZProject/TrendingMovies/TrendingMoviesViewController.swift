//
//  TrendingMoviesViewController.swift
//  BAZProject
//
//  Created Octavio Labastida Luna on 19/04/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class TrendingMoviesViewController: UITableViewController, TrendingMoviesViewProtocol {

	var presenter: TrendingMoviesPresenterProtocol?
    
    var searchController: UISearchController!
    
    var resultsTableController: ResultsTableController!
    
    var movies: [ListMovieProtocol] = []
    
    var searchResultMovies: [ListMovieProtocol] = []
    
    var restoredState: RestorableState = SearchControllerRestorableState()

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMovies()
        configureSearch()
    }
    
    func loadData(movies: [ListMovieProtocol]) {
        self.movies = movies
        tableView.reloadData()
    }
    
    func loadSearchData(movies: [ListMovieProtocol]) {
        self.searchResultMovies = movies
    }

    func configureSearch(){
        searchController = UISearchController(searchResultsController: presenter?.getResultViewController())
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

// MARK: - TableView's DataSource

extension TrendingMoviesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingMoviesViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        presenter?.getRemotImage(from: movies[indexPath.row].posterPath, completion: { image in
            config.image = image
            cell.contentConfiguration = config
        })
    }

}

// MARK: - UISearchBarDelegate

extension TrendingMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
}
