//
//  TrendingMoviesViewController+Updating.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 21/04/23.
//

import Foundation
import UIKit

extension TrendingMoviesViewController: UISearchResultsUpdating{

    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText =  searchController.searchBar.text else { return }
        
        presenter?.findMovies(for: searchText, completion: {[weak self] movies in
            guard let strongSelf = self else { return }
            strongSelf.searchResultMovies = movies
            if let resultsController = searchController.searchResultsController as? ResultsTableController {
                resultsController.filteredProducts = strongSelf.searchResultMovies
                resultsController.tableView.reloadData()
                resultsController.resultsLabel.text = resultsController.filteredProducts.isEmpty ?
                    NSLocalizedString("NoItemsFoundTitle", comment: "") :
                    String(format: NSLocalizedString("Items found: %ld", comment: ""),
                           resultsController.filteredProducts.count)
            }
            
        })
    }
    
}
