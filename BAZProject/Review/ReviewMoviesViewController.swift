//
//  ReviewMoviesViewController.swift
//  BAZProject
//
//  Created by ksolano on 18/04/23.
//

import UIKit

final class ReviewMoviesViewController: UIViewController {
    
    var presenter: ReviewMoviesViewOutputProtocol?
    var movie: Movie?
    var movieReview: MovieReview?
    var moviesRecomendations: [Movie] = []
    var moviesSimiliar: [Movie] = []
    private let imageLoader: ImageLoader = ImageLoader()
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var recomendationsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
        presenter?.reviewMovies(url: "movie/\(movie?.id ?? 0)/reviews?api_key=")
        presenter?.recomendedMovies(url: "movie/\(movie?.id ?? 0)/recommendations?api_key=")
        presenter?.similarMovies(url: "movie/\(movie?.id ?? 0)/similar?api_key=")
    }
    // ReviewMoviesViewController configuration to be used
    func registerTable() {
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register(UINib(nibName: "MoviesTableViewCell",
                                       bundle: Bundle(for: ReviewMoviesViewController.self)),
                                 forCellReuseIdentifier: "MoviesCell")
        reviewTableView.register(UINib(nibName: "InfoReviewTableViewCell",
                                       bundle: Bundle(for: ReviewMoviesViewController.self)),
                                 forCellReuseIdentifier: "InfoReviewCell")
        
        recomendationsCollectionView.delegate = self
        recomendationsCollectionView.dataSource = self
        recomendationsCollectionView.register(UINib(nibName: "MoviesCollectionViewCell",
                                            bundle: Bundle(for: ReviewMoviesViewController.self)), forCellWithReuseIdentifier: "MoviesCollectionCell")
    }
    
    // User tap into back button and come back to Home
    @IBAction func backAction(_ sender: UIButton) {
        presenter?.popViewController()
    }
    
}

extension ReviewMoviesViewController: ReviewMoviesViewInputProtocol {
    /// Fecth return similar movies information with movies
    /// - Parameters:
    ///    - movies: receive a [Movie]
    func showSimilarMovies(similarMovies: [Movie]) {
        self.moviesSimiliar = similarMovies
        debugPrint("Similar movies:", self.moviesSimiliar)
        recomendationsCollectionView.reloadData()
    }
    
    /// Fecth return recomended movies information with movies
    /// - Parameters:
    ///    - movies: receive a [Movie]
    func showRecomendedMovies(recomendedMoviess: [Movie]) {
        self.moviesRecomendations = recomendedMoviess
        debugPrint("Recomended movies:", self.moviesRecomendations)
        recomendationsCollectionView.reloadData()
    }
    
    /// Fecth return movie information with movies
    /// - Parameters:
    ///    - movies: receive a [Movie]
    func showReviewMovies(movie: MovieReview) {
        self.movieReview = movie
        reviewTableView.reloadData()
    }
}

extension ReviewMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Configuration for Table View with datasource of movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 || section == 1 ? 1 : 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == 0 ? 140 : 450
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: "MoviesCell") as? MoviesTableViewCell else {
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
        case 1:
            guard let cell = reviewTableView.dequeueReusableCell(withIdentifier: "InfoReviewCell") as? InfoReviewTableViewCell else {
                return UITableViewCell()
            }
            cell.infoLabelText = (self.movieReview?.content?.prefix(700) ?? "Descripción") + "..."
            cell.ratingLabelText = self.movie?.vote_average?.toString() ?? "0.0"

            return cell
        case 2:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

extension ReviewMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Configuration for Collection View with datasource of movies
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.moviesRecomendations.count
        case 1:
           return  self.moviesSimiliar.count
        default:
           return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.recomendationsCollectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionCell", for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        switch indexPath.section {
        case 0:
            cell.movieFavButton.isHidden = true
            cell.movieData = self.moviesRecomendations[indexPath.row]
            cell.titleLabel = self.moviesRecomendations[indexPath.row].title ?? ""
            guard let url = imageLoader.getURLImage(poster_path: self.moviesRecomendations[indexPath.row].poster_path ?? "") else {
                return cell
            }
            imageLoader.loadImage(urlData: url) { image in
                cell.image = image ?? UIImage()
            }
            return cell
        case 1:
            cell.movieFavButton.isHidden = true
            cell.movieData = self.moviesSimiliar[indexPath.row]
            cell.titleLabel = self.moviesSimiliar[indexPath.row].title ?? ""
            guard let url = imageLoader.getURLImage(poster_path: self.moviesSimiliar[indexPath.row].poster_path ?? "") else {
                return cell
            }
            imageLoader.loadImage(urlData: url) { image in
                cell.image = image ?? UIImage()
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    /// if select a movie of recomended go to this module with another movie
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let reviewView = ReviewMoviesRouter.createModule(movieReview: self.moviesRecomendations[indexPath.row])
            self.navigationController?.pushViewController(reviewView, animated: true)
        case 1:
            let reviewView = ReviewMoviesRouter.createModule(movieReview: self.moviesSimiliar[indexPath.row])
            self.navigationController?.pushViewController(reviewView, animated: true)
        default:
            debugPrint("No se pudo seleccionar correctamente")
        }
    }
}
// Extension for give format to the raiting
extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
