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

///ViewController que contiene la vista del Modulo Viper de TrendigMovies
/// - Parameters:
///    - presenter: Intancia del Presenter del modulo VIPER
///    - searchController: The gearing of the bicycle
///    - movies: The handlebar of the bicycle
///    - searchResultMovies: The frame size of the bicycle, in centimeters
///    - restoredState: The frame size of the bicycle, in centimeters
/// - Returns: Regrea un ViewController
final class TrendingMoviesViewController: UITableViewController, TrendingMoviesViewProtocol {
    /// Intancia del Presenter  del modulo VIPER Trending Movies
	var presenter: TrendingMoviesPresenterProtocol?
    /// Intancia de un UISearchController  que permite buscar una pelicula en la api de MovieDB
    var searchController: UISearchController?
    /// Intancia de un UITableViewContrller  muestra los resuiltados una pelicula en la api de MovieDB
    var resultsTableController: ResultsTableController?
    /// Arreglo que contiene las peliculas que despliegan en una lista
    var movies: [ListMovieProtocol] = []{
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    /// Arreglo que contiene las peliculas que despliegan en una lista deacuerdo a un criterio de busqueda
    var searchResultMovies: [ListMovieProtocol] = []
    /// Intancia de RestorableStateProtocol que guarda el estado del ResultTableViewController
    var restoredState: RestorableStateProtocol = SearchControllerRestorableState()

    // MARK: ViewController Lifecycle
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getMovies()
        resultsTableController = configureTableViewSearch()
        searchController = configureSearch()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - SearchBarController Configuration

extension TrendingMoviesViewController{
    ///Metodo que establece la configuracion inicial de SearchBArViewController
    func configureSearch() -> UISearchController{
        guard let resultsTableController = resultsTableController else { return UISearchController() }
        let search = UISearchController(searchResultsController: resultsTableController)
        search.searchResultsUpdater = self
        search.searchBar.autocapitalizationType = .none
        search.searchBar.delegate = self
        return search
    }
    
    func configureTableViewSearch() -> ResultsTableController{
        guard let viewController: ResultsTableController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableController else { return ResultsTableController() }
        return viewController
    }
}

// MARK: - View - Presenter Method's

extension TrendingMoviesViewController{
    ///Funcion que carga en un arreglo de Movies la informacion que regresa el API de MovieDB y recarga la el UITableView
    /// - Parameters:
    ///     -Movies: Array de ListMovieProtocol
    func loadData(movies: [ListMovieProtocol]) {
        self.movies = movies
    }
    ///Funcion que carga en un arreglo de Movies la informacion que regresa el API de MovieDB de acuerdo a un criterio de busqueda  y recarga la el UITableView
    /// - Parameters:
    ///     -Movies: Array de ListMovieProtocol
    func loadSearchData(movies: [ListMovieProtocol]) {
        self.searchResultMovies = movies
    }
}

// MARK: - TableView's DataSource

extension TrendingMoviesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath)
        let movie = movies[indexPath.row]
        guard let url = movie.urlImage else { return UITableViewCell() }
        cell.textLabel?.text = movie.title
        cell.imageView?.loadRemoteImage(url: url)
        return cell
    }

}

// MARK: - UISearchBarDelegate

extension TrendingMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let searchController = searchController else { return }
        updateSearchResults(for: searchController)
    }
    
}
// MARK: - UISearchResultsUpdating

extension TrendingMoviesViewController: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        presenter?.findMovies(for: searchController.searchBar.text)
    }
}
