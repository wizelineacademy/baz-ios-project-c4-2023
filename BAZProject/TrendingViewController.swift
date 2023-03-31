//
//  TrendingViewController.swift
//  BAZProject
//  by Kevin Solano
//  Get the Trending movies of API

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [MovieProtocol] = []
    // Instance of a struct that define loaderImage method
    private let imageLoader: ImageLoader = ImageLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // moviesFecth have a Movie elements for test our MovieProtocol
        // to test MovieAPI decoupling comment this line of code
       movies = MoviesFecth.moviesFecth
        
        // to test MovieAPI discomment this block of code 20 - 33 lines
        /*
         let movieApi = MovieAPI()
        movieApi.getMovies { movies in
            self.movies = movies
            if self.verifyInformation(movies: self.movies) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("No se mostrará información (TableView)")
            }
        }
         */
    }
    
    // verify movie informaation for show at least one movie
    func verifyInformation(movies: [MovieProtocol]) -> Bool {
        if movies.count > 0 {
            return true
        }
        return false
    }
    
    // verify id of movie
    func verificationId(movieIndex: Int) -> Bool {
        if movieIndex <= movies.count {
            return movies[movieIndex].id > 0
        }
        return false
    }
    
    func getURLImage(poster_path: String) -> URL? {
        let base = "https://image.tmdb.org/t/p/w500"
        return URL(string: base + poster_path)
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
        guard let urlMovieImage = getURLImage(poster_path: movies[indexPath.row].poster_path) else {
            return
        }
        imageLoader.loadImage(urlData: urlMovieImage) { image in
            config.image = image
            cell.contentConfiguration = config
        }
    }

}
