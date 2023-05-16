//
//  MovieDetailProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 27/04/23.
//  
//

import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func reloadData()
}

protocol MovieDetailRouterProtocol: AnyObject {
    static func createMovieDetailModule(of movieId: Int) -> UIViewController
}

protocol MovieDetailPresenterProtocol: AnyObject {
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    var movieDetail: MovieDetail? { get set }
    var movieId: Int { get set }
    var isFavorite: Bool { get set }
    
    func saveFavoriteMovie()
    func deleteToFavoriteMovie()
    func notifyViewLoaded()
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func movieDetailFetched(with movieDetail: MovieDetail)
}

protocol MovieDetailInteractorInputProtocol: AnyObject {
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var data: MovieDetail? { get set }
    var saveData: MovieFavorites { get }
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol? { get set }
    
    func saveFavoriteMovie(of movieId: Int?)
    func deleteToFavoriteMovie(of movieId: Int?)
    func fetchMovieDetail(of movieId: Int?)
}

protocol MovieDetailRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovieDetail(of movieId: Int)

}

protocol MovieDetailRemoteDataManagerOutputProtocol: AnyObject {
    func movieDetailFetched(with movieDetail: MovieDetail)
}
