//
//  MovieView.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import UIKit

class MovieView: UITableViewController {

    // MARK: Properties
    var presenter: MoviePresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }

}

//MARK: TrendingViewProtocols
extension  MovieView: MovieViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView's DataSource
extension MovieView {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.movies?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") else { return UITableViewCell() }
        return tableViewCell
    }

}

// MARK: - TableView's Delegate
extension MovieView {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = self.presenter?.movies?[indexPath.row].title
        if let posterPath = self.presenter?.movies?[indexPath.row].posterPath, let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            imageURL.toImage() { image in
                DispatchQueue.main.async {
                    config.image = image
                    cell.contentConfiguration = config
                }
            }
        } else {
            config.image = UIImage(named: "poster")
            cell.contentConfiguration = config
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.goToMovieDetail(of: indexPath,from: self)
    }
}
