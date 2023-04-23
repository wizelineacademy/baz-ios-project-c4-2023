//
//  HomeViewController.swift
//  BAZProject
//
//  Created by ksolano on 18/04/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var presenter: HomeViewOutputProtocol?
    var sectionsMovies: SectionsMovies?
    var movies:  [MovieProtocol] = []
    var populars: [MovieProtocol] = []
    var cineMovie: [MovieProtocol] = []
    private let imageLoader: ImageLoader = ImageLoader()
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        movieFecth()
        popularMoviesFetch()
        cineMoviesFetch()
    }
    // MoviesCollectionViewCell configuration to be used
    func setUpCollectionView()  {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        moviesCollectionView.register(UINib(nibName: "MoviesCollectionViewCell",
                                            bundle: Bundle(for: HomeViewController.self)), forCellWithReuseIdentifier: "MoviesCollectionCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // Get a complete URL, having a base url we can complete de URL with poster_path and return it
    func getURLImage(poster_path: String) -> URL? {
        let base = "https://image.tmdb.org/t/p/w500"
        return URL(string: base + poster_path)
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
    // We want to show Search module VIPER
    @IBAction func searchAction(_ sender: UIButton) {
        let seacrhView = SearchMoviesRouter.createModule()
        presenter?.pushViewController(view: seacrhView)
    }
    
}

extension HomeViewController: HomeViewInputProtocol {
    // Movies that return the fecth
    func showCategories(movies: [MovieProtocol], section: Int) {
        
        switch section {
        case 0:
            self.movies = movies
        case 1:
            self.populars = movies
        case 2:
            self.cineMovie = movies
        default:
            debugPrint("Invalid Sección")
        }
        moviesCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // Collection view configuration with Datasource returned of fetchs
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionCell",
                                                                       for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.movieTitle.text = self.movies[indexPath.row].title
            let url = getURLImage(poster_path: self.movies[indexPath.row].poster_path ?? "")!
            imageLoader.loadImage(urlData: url) { image in
                cell.movieImage.image = image
            }
            return cell
        case 1:
            cell.movieTitle.text = self.populars[indexPath.row].title
            let url = getURLImage(poster_path: self.populars[indexPath.row].poster_path ?? "")!
            imageLoader.loadImage(urlData: url) { image in
                cell.movieImage.image = image
            }
            return cell
        case 2:
            cell.movieTitle.text = self.cineMovie[indexPath.row].title
            let url = getURLImage(poster_path: self.cineMovie[indexPath.row].poster_path ?? "")!
            imageLoader.loadImage(urlData: url) { image in
                cell.movieImage.image = image
            }
            return cell
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.movies.count
        case 1:
            return self.populars.count
        case 2:
            return self.cineMovie.count
        default:
            return 0
        }
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (view.frame.width-10)/3.5
        return CGSize(width: width, height: width * 2.5)
    }
    // Configuration for Header section
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = moviesCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TitleCollectionReusableView", for: indexPath) as? TitleCollectionReusableView {
            switch indexPath.section {
            case 0:
                sectionHeader.titleLabel = "Tendencia"
            case 1:
                sectionHeader.titleLabel = "Populares"
            case 2:
                sectionHeader.titleLabel = "Solo en Cines"
            default:
                sectionHeader.titleLabel = "Tendencia"
            }
            return sectionHeader
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}
