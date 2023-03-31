//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [Movie] = []
    var movieDataProvider: MovieDataProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Inicializa la clase MovieApi como el proveedor de datos por defecto
        self.movieDataProvider = MovieApi()
        // Obtiene la lista de películas usando el proveedor de datos
        self.movieDataProvider?.getMovies { movies in
            self.movies = movies
                   
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
