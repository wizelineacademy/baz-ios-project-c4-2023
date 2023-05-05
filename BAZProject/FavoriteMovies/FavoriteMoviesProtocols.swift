//
//  FavoriteMoviesProtocols.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import Foundation

//MARK: - View

/// Presenter -> View
protocol FavoriteMoviesViewProtocol: AnyObject {
    var presenter: FavoriteMoviesPresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
    func updateMovies()
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol FavoriteMoviesInteractorOutputProtocol: AnyObject {
    func presentMovies()
}

/// Presenter -> Interactor
protocol FavoriteMoviesInteractorInputProtocol: AnyObject {
    var presenter: FavoriteMoviesInteractorOutputProtocol? { get set }
    var entity: FavoriteMoviesEntity? { get set }
    var movies: [MovieInfo]? { get set }
    
    func getNavTitle() -> String?
    func loadFavoriteMovies()
    func getMovie(for indexPath: IndexPath) -> MovieInfo?
    func getMoviesCount() -> Int?
}

//MARK: - Presenter

/// View -> Presenter
protocol FavoriteMoviesPresenterProtocol: AnyObject {
    var view: FavoriteMoviesViewProtocol? { get set }
    var interactor: FavoriteMoviesInteractorInputProtocol? { get set }
    var router: FavoriteMoviesRouterProtocol? { get set }
    
    func viewDidLoad()
    func loadMovies()
    func attach(view: FavoriteMoviesViewProtocol?)
    func present()
    
    func numberOfRows() -> Int?
    func getMovie(for indexPath: IndexPath) -> MovieInfo?
    func goToMovieDetails(for indexPath: IndexPath)
}

//MARK: - Router

/// Presenter -> Router
protocol FavoriteMoviesRouterProtocol: AnyObject {
    func present(presenter: FavoriteMoviesPresenterProtocol)
    func goToMovieDetailsView(_ movie: MovieInfo, parent: FavoriteMoviesViewProtocol?)
    func popView()
}
