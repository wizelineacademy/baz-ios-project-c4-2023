//
//  HomeViewController.swift
//  BAZProject
//
//  Created by ksolano on 18/04/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var presenter: HomeViewOutputProtocol?
    var movies:  [Movie] = []
    var populars: [Movie] = []
    var cineMovies: [Movie] = []
    var topMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var allMovies: [Movie] = []
    var movieSelected : Movie? = nil
    let categorias = ["Todas", "Tendencias", "Populares", "Solo en cines", "Top", "Proximamente"]
    private let imageLoader: ImageLoader = ImageLoader()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var categoriesMenuCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        movieFecth()
    }
    // MoviesCollectionViewCell configuration to be used
    func setUpCollectionView()  {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell",
                                            bundle: Bundle(for: HomeViewController.self)), forCellWithReuseIdentifier: "MoviesCollectionCell")
        categoriesMenuCollection.delegate = self
        categoriesMenuCollection.dataSource = self
        categoriesMenuCollection.register(UINib(nibName: "CategoriesMenuCollectionViewCell",
                                            bundle: Bundle(for: HomeViewController.self)), forCellWithReuseIdentifier: "CategoriesMenuCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // Fetch to get trending movies from API
    func movieFecth() {
        presenter?.fetchCategories(url: "trending/movie/day?api_key=", section: 0)
    }
    // Fetch to get popular movies from API
    func popularMoviesFetch() {
        presenter?.fetchCategories(url: "movie/popular?api_key=", section: 1)
    }
    // Fetch to get now playing movies from API
    func cineMoviesFetch() {
        presenter?.fetchCategories(url: "movie/now_playing?api_key=", section: 2)
    }
    func topMoviesFetch() {
        presenter?.fetchCategories(url: "movie/top_rated?api_key=", section: 3)
    }
    func upcomingMoviesFetch() {
        presenter?.fetchCategories(url: "movie/upcoming?api_key=", section: 4)
    }
    // We want to show Search module VIPER
    @IBAction func searchAction(_ sender: UIButton) {
        let seacrhView = SearchMoviesRouter.createModule()
        presenter?.pushSearchViewController(view: seacrhView)
    }
    
    @IBAction func goFavoritesView(_ sender: UIButton) {
        let favoritesView = FavouriteMoviesRouter.createModule()
        self.presenter?.pushSearchViewController(view: favoritesView)
    }
}

extension HomeViewController: HomeViewInputProtocol {
    /// Movies and section that return the fecth
    /// - Parameters:
    ///   - movies: a [Movie]
    ///   - section: the section where the information will be displayed
    func showCategories(movies: [Movie], section: Int) {
        
        switch section {
        case 0:
            self.movies = movies
            popularMoviesFetch()
        case 1:
            self.populars = movies
            cineMoviesFetch()
        case 2:
            self.cineMovies = movies
            topMoviesFetch()
        case 3:
            self.topMovies = movies
            upcomingMoviesFetch()
        case 4:
            self.upcomingMovies = movies
        default:
            debugPrint("Invalid Sección")
        }
        moviesCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // Collection view configuration with Datasource returned of fetchs
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == moviesCollectionView {
            guard let cell = self.moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionCell", for: indexPath) as? MoviesCollectionViewCell else {
                return UICollectionViewCell()
            }
            switch indexPath.section {
            case 0:
                cell.subscribeButtonAction = {
                    self.presenter?.storeFav(movieFav: self.movies[indexPath.row])
                }
                cell.movieData = self.movies[indexPath.row]
                cell.titleLabel = self.movies[indexPath.row].title ?? ""
                guard let url = imageLoader.getURLImage(poster_path: self.movies[indexPath.row].poster_path ?? "") else {
                    return cell
                }
                imageLoader.loadImage(urlData: url) { image in
                    cell.image = image ?? UIImage()
                }
                return cell
            case 1:
                cell.subscribeButtonAction = {
                    self.presenter?.storeFav(movieFav: self.populars[indexPath.row])
                }
                cell.movieData = self.populars[indexPath.row]
                cell.movieTitle.text = self.populars[indexPath.row].title
                guard let url = imageLoader.getURLImage(poster_path: self.populars[indexPath.row].poster_path ?? "") else {
                    return cell
                }
                imageLoader.loadImage(urlData: url) { image in
                    cell.movieImage.image = image
                }
                return cell
            case 2:
                cell.subscribeButtonAction = {
                    self.presenter?.storeFav(movieFav: self.cineMovies[indexPath.row])
                }
                cell.movieData = self.cineMovies[indexPath.row]
                cell.movieTitle.text = self.cineMovies[indexPath.row].title
                guard let url = imageLoader.getURLImage(poster_path: self.cineMovies[indexPath.row].poster_path ?? "") else {
                    return cell
                }
                imageLoader.loadImage(urlData: url) { image in
                    cell.movieImage.image = image
                }
                return cell
            case 3:
                cell.subscribeButtonAction = {
                    self.presenter?.storeFav(movieFav: self.topMovies[indexPath.row])
                }
                cell.movieData = self.topMovies[indexPath.row]
                cell.movieTitle.text = self.topMovies[indexPath.row].title
                guard let url = imageLoader.getURLImage(poster_path: self.topMovies[indexPath.row].poster_path ?? "") else {
                    return cell
                }
                imageLoader.loadImage(urlData: url) { image in
                    cell.movieImage.image = image
                }
                return cell
            case 4:
                cell.subscribeButtonAction = {
                    self.presenter?.storeFav(movieFav: self.upcomingMovies[indexPath.row])
                }
                cell.movieData = self.upcomingMovies[indexPath.row]
                cell.movieTitle.text = self.upcomingMovies[indexPath.row].title
                guard let url = imageLoader.getURLImage(poster_path: self.upcomingMovies[indexPath.row].poster_path ?? "") else {
                    return cell
                }
                imageLoader.loadImage(urlData: url) { image in
                    cell.movieImage.image = image
                }
                return cell
            default:
                return cell
            }
        } else if collectionView == categoriesMenuCollection {
            guard let cell = self.categoriesMenuCollection.dequeueReusableCell(withReuseIdentifier: "CategoriesMenuCell",
                                                                           for: indexPath) as? CategoriesMenuCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.categoriesLabelText = categorias[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == moviesCollectionView {
            switch section {
            case 0:
                return self.movies.count
            case 1:
                return self.populars.count
            case 2:
                return self.cineMovies.count
            case 3:
                return self.topMovies.count
            case 4:
                return self.upcomingMovies.count
            default:
                return 0
            }
        } else if collectionView == categoriesMenuCollection {
            return 5
        }else {
            return 3
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == moviesCollectionView {
            return 5
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == moviesCollectionView {
            let width  = (view.frame.width-10)/3.5
            return CGSize(width: width, height: width * 2.5)
        } else {
            return CGSize(width: 150, height: 50)
        }
    }
    // Configuration for Header section
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if collectionView == moviesCollectionView {
            if let sectionHeader = moviesCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TitleCollectionReusableView", for: indexPath) as? TitleCollectionReusableView {
                switch indexPath.section {
                case 0:
                    sectionHeader.titleLabel = "Tendencias"
                case 1:
                    sectionHeader.titleLabel = "Populares"
                case 2:
                    sectionHeader.titleLabel = "Solo en Cines"
                case 3:
                    sectionHeader.titleLabel = "Top"
                case 4:
                    sectionHeader.titleLabel = "Proximamente"
                default:
                    sectionHeader.titleLabel = "Proximamente"
                }
                return sectionHeader
            } else {
                return UICollectionViewCell()
            }
        } else if collectionView == categoriesMenuCollection {
            return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoriesMenuCollection {
            
            moviesCollectionView.presentationSectionIndex(forDataSourceSectionIndex: indexPath.section)
        } else if collectionView == moviesCollectionView {
            switch indexPath.section {
            case 0:
                movieSelected = self.movies[indexPath.row]
            case 1:
                movieSelected = self.populars[indexPath.row]
            case 2:
                movieSelected = self.cineMovies[indexPath.row]
            case 3:
                movieSelected = self.topMovies[indexPath.row]
            case 4:
                movieSelected = self.upcomingMovies[indexPath.row]
            default:
                debugPrint("Ningún elemento seleccionado")
            }
            guard let movieToReview = movieSelected else {
                debugPrint("No pudimos obtener la pelicula seleccionada")
                return
            }
            let reviewView = ReviewMoviesRouter.createModule(movieReview: movieToReview)
            self.presenter?.pushSearchViewController(view: reviewView)
        }
    }
}
