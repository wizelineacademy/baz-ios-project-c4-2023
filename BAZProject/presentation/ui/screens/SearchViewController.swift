//
//  SearchViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 15/04/23.
//

import UIKit

class SearchViewController: ReusableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
    override func setupView() {
        super.setupView()
        setupSearchController()
    }
    
    private func setupSearchController() {
        // Do any additional setup after loading the view.
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "What are you looking for?"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

    }
}

extension SearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        // El controlador de búsqueda se presentó en la interfaz de usuario
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Se ha ingresado texto en la barra de búsqueda
    }
}
