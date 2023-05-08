//
//  SearchMoviesViewController.swift
//  BAZProject
//
//  Created by ksolano on 18/04/23.
//

import UIKit

final class SearchMoviesViewController: UIViewController {
    
    var presenter: SearchMoviesViewOutputProtocol?
    var movies: [Movie] = []
    private let imageLoader: ImageLoader = ImageLoader()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
        movieFecth()
    }
    // SearchMoviesViewController configuration to be used
    func registerTable() {
        searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: "MoviesTableViewCell",
                                       bundle: Bundle(for: SearchMoviesViewController.self)),
                                 forCellReuseIdentifier: "MoviesCell")
        searchTableView.register(UINib(nibName: "MoviesErrorTableViewCell",
                                       bundle: Bundle(for: SearchMoviesViewController.self)),
                                 forCellReuseIdentifier: "MoviesErrorCell")
    }
    
    // Fetch to get trending movies from API
    func movieFecth() {
        presenter?.searchMovies(url: "trending/movie/day?api_key=", key: "")
    }
    // User tap into back button and come back to Home
    @IBAction func backAction(_ sender: UIButton) {
        presenter?.popViewController()
    }
    
}

extension SearchMoviesViewController: SearchMoviesViewInputProtocol {
    /// Fecth return movie information with movies
    /// - Parameters:
    ///    - movies: receive a [Movie]
    func showSearchMovies(movies: [Movie]) {
        self.movies = movies
        searchTableView.reloadData()
    }
}

extension SearchMoviesViewController: UISearchBarDelegate {
    // User search text (movie) in the searcher bar, call to API for get movies by means of a key
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let textSearched = searchText.filter { "a"..."z" ~= $0 || "A"..."Z" ~= $0  || "0"..."9" ~= $0 }
        if textSearched.isEmpty {
            movieFecth()
        }else{
            presenter?.searchMovies(url: "search/movie?api_key=", key: "&language=es&query=" + textSearched)
        }
    }
}

extension SearchMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Configuration for Table View with datasource of movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.movies.count == 0 {
            return  1
        } else {
            return self.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.movies.count == 0 {
            return  600.0
        } else {
            return 155.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if movies.count == 0 {
            guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "MoviesErrorCell") as? MoviesErrorTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "MoviesCell") as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.movieTitleLabel.text = self.movies[indexPath.row].title ?? "titúlo"
        guard let url = imageLoader.getURLImage(poster_path: self.movies[indexPath.row].poster_path ?? "") else {
            return cell
        }
        imageLoader.loadImage(urlData: url) { image in
            cell.movieImage.image = image
        }
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reviewView = ReviewMoviesRouter.createModule(movieReview: self.movies[indexPath.row])
        self.navigationController?.pushViewController(reviewView, animated: true)
    }
    
}
