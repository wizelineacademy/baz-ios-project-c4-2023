//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [MovieInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.getMovies()
        }
        
    }
    
    func configView() {
        self.tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: MovieListCell.reusableIdentifier)
    }

    fileprivate func reloadMoviesData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func getMovies() {
        let movieApi = MovieAPI()
        movieApi.getMovies { movies in
            if let movies = movies, movies.count > 0 {
                self.updateMovies(movies)
                self.reloadMoviesData()
            } else {
                print("Empty results.")
            }
        }
    }
    
    /**
     Set movies object into viewController.
     - Parameters:
        - arrMovies: An array of objects of type `MovieInfo` protocol.
     */
    private func updateMovies(_ arrMovies: [MovieInfo]) {
        self.movies = arrMovies
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reusableIdentifier) as? MovieListCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movieInfo = movies[indexPath.row]
        (cell as? MovieListCell)?.setData(with: movieInfo)
    }

}
