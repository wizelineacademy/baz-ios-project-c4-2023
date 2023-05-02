//
//  HomeProtocols.swift
//  BAZProject
//
//  Created by Carlos Garcia on 20/04/23.
//  
//

import Foundation
import UIKit

//MARK: - View

/// Presenter -> View
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
    func updateSectionsData(_ collectionList: [MovieListCollectionView])
    func showMoviesFound(_ movies: [MovieFoundInfo]?)
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol HomeInteractorOutputProtocol: AnyObject {
    func updateSectionsData(_ sections: [MovieSection])
    func updateMovies(_ movies: [MovieInfo]?, in section: Int)
    func updateMoviesFound(_ movies: [MovieFoundInfo]?)
}

/// Presenter -> Interactor
protocol HomeInteractorInputProtocol: AnyObject {
    var presenter: HomeInteractorOutputProtocol? { get set }
    var movieAPI: MovieAPI? { get set }
    var entity: HomeEntity? { get set }
    
    func getNavTitle() -> String?
    func setSectionsData()
    
    func fetchMovies(for section: Int)
    func getMovie(for indexPath: IndexPath) -> MovieInfo?
    
    func searchMovies(for text: String)
    func getMovieFoundCount() -> Int?
    func getMovieFound(for index: Int) -> MovieFoundInfo?
}

//MARK: - Presenter

/// View -> Presenter
protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func getData()
    func fetchMovies()
    func numberOfRows() -> Int
    func getSearchMovie(for indexPath: IndexPath) -> MovieInfo?
    func fetchMovieDetails(for indexPath: IndexPath)
    func fetchMovies(for text: String?)
}

//MARK: - Router

/// Presenter -> Router
protocol HomeRouterProtocol: AnyObject {
    static func createHomeModule(withEntity entity: HomeEntity) -> UIViewController
    func goToMovieDetailsView(_ movie: MovieInfo, parent: HomeViewProtocol?)
}
