//
//  MoviesViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation
import UIKit

class MovieListViewController: ReusableTableViewController<MovieItemCell, Movie>, MovieListsViewProtocol {

    var presenter: MovieListsPresenterProtocol?

    // MARK: - Override Functions
    override func setupView() {
        super.setupView()
    }

    override func configTableView() {
        super.configTableView()
        height = 110
        table_view.separatorStyle = .none
        presenter?.loadMovies()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt : \(items[indexPath.row])")
    }

    // MARK: - Protocols Functions
    func showMovies(_ movies: [Movie]) {
        items = movies
        DispatchQueue.main.async {
            self.table_view.reloadData()
        }
    }

    // MARK: - Private Functions
}
