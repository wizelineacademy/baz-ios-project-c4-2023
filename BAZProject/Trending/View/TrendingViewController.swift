//
//  TrendingViewController.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//

import UIKit

class TrendingViewController: UITableViewController {
        
    var movies: [Movie] = []
    var movieDataProvider: MovieDataProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: TrendingTableViewCell.identifier, bundle : nil), forCellReuseIdentifier: TrendingTableViewCell.identifier)
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as? TrendingTableViewCell{
            return cell
        }else{
            let cell = UITableViewCell()
            return cell
        }
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
