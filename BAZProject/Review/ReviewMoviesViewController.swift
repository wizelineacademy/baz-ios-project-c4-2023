//
//  ReviewMoviesViewController.swift
//  BAZProject
//
//  Created by ksolano on 18/04/23.
//

import UIKit

final class ReviewMoviesViewController: UIViewController {
    
    var presenter: ReviewMoviesViewOutputProtocol?
    var movie: MovieProtocol? = nil
    private let imageLoader: ImageLoader = ImageLoader()
    
    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
        presenter?.reviewMovies(idMovie: "603")
    }
    // ReviewMoviesViewController configuration to be used
    func registerTable() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: "MoviesTableViewCell",
                                       bundle: Bundle(for: ReviewMoviesViewController.self)),
                                 forCellReuseIdentifier: "MoviesCell")
        searchTableView.register(UINib(nibName: "MoviesErrorTableViewCell",
                                       bundle: Bundle(for: ReviewMoviesViewController.self)),
                                 forCellReuseIdentifier: "MoviesErrorCell")
    }
    
    // User tap into back button and come back to Home
    @IBAction func backAction(_ sender: UIButton) {
        presenter?.popViewController()
    }
    
}

extension ReviewMoviesViewController: ReviewMoviesViewInputProtocol {
    
    /// Fecth return movie information with movies
    /// - Parameters:
    ///    - movies: receive a [MovieProtocol]
    func showReviewMovies(movie: MovieProtocol) {
        self.movie = movie
        searchTableView.reloadData()
    }
}

extension ReviewMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Configuration for Table View with datasource of movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return  1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return  600.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "MoviesCell") as? MoviesTableViewCell else {
            return UITableViewCell()
        }
        cell.movieTitleLabel.text = self.movie?.title ?? "titúlo"
        guard let url = imageLoader.getURLImage(poster_path: self.movie?.poster_path ?? "") else {
            return cell
        }
        imageLoader.loadImage(urlData: url) { image in
            cell.movieImage.image = image
        }
        return cell
    }
    
}
