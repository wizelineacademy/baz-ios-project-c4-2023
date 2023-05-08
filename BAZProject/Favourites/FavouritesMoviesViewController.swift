//
//  FavouriteMoviesViewController.swift
//  BAZProject
//
//  Created by ksolano on 18/04/23.
//

import UIKit

final class FavouriteMoviesViewController: UIViewController {
    
    var presenter: FavouriteMoviesViewOutputProtocol?
    var movies: [Movie] = []
    private let imageLoader: ImageLoader = ImageLoader()
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favoritos"
        registerTable()
        presenter?.favouriteMovies()
    }
    // FavouriteMoviesViewController configuration to be used
    func registerTable() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.register(UINib(nibName: "MoviesTableViewCell",
                                       bundle: Bundle(for: FavouriteMoviesViewController.self)),
                                 forCellReuseIdentifier: "MoviesCell")
        favoritesTableView.register(UINib(nibName: "MoviesErrorTableViewCell",
                                       bundle: Bundle(for: FavouriteMoviesViewController.self)),
                                 forCellReuseIdentifier: "MoviesErrorCell")
    }
    
    // User tap into back button and come back to Home
    @IBAction func backAction(_ sender: UIButton) {
        presenter?.popViewController()
    }
    // User tap into trash button for delte all the movies in UserDafaluts
    @IBAction func deleteButton(_ sender: UIButton) {
        presenter?.deleteFavouritesMovies()
    }
}

extension FavouriteMoviesViewController: FavouriteMoviesViewInputProtocol {
    
    /// Fecth return movie information with movies
    /// - Parameters:
    ///    - movies: receive a [Movie]
    func showFavouriteMovies(movies: [Movie]) {
        self.movies = movies
        favoritesTableView.reloadData()
    }
}

extension FavouriteMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Configuration for Table View with datasource of movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return  220.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "MoviesCell") as? MoviesTableViewCell else {
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
    
    /// When select a favourite movie  for show the review
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reviewView = ReviewMoviesRouter.createModule(movieReview: self.movies[indexPath.row])
        self.navigationController?.pushViewController(reviewView, animated: true)
    }
    
}
