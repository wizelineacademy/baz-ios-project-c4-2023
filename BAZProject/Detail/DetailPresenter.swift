//
//  DetailPresenter.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

// MARK: - Class
class DetailPresenter {
    // MARK: - Properties
    weak var view: DetailViewInputProtocol?
    var interactor: DetailInteractorInputProtocol
    var router: DetailRouterProtocol
    var detailMovie: ListMovieProtocol
    
    init(view: DetailViewInputProtocol,
         interactor: DetailInteractorInputProtocol,
         router: DetailRouterProtocol,
         detailMovie: ListMovieProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.detailMovie = detailMovie
    }
}

// MARK: - Extensions

// MARK: - V I E W · T O · P R E S E N T E R
extension DetailPresenter: DetailViewOutputProtocol {
    // MARK: - Functions
    func getDetailMovie() {
        interactor.getDetailMovie(detailMoviePI: self.detailMovie)
    }
    
    func getOriginalMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void) {
        interactor.getOriginalMovieImage(imagePath: imagePath, completion: completion)
    }
    
    func getSimilarMovies(endPoint: Endpoint) {
        interactor.getSimilarMovies(endPoint: endPoint) {
            
        }
    }
    
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        interactor.getMovieImage(index: index, completion: completion)
    }
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension DetailPresenter: DetailInteractorOutputProtocol {
    // MARK: - Functions
    func presentDetailMovie(detailMovie: ListMovieProtocol) {
        view?.showDetailMovie(detailMovie: detailMovie)
    }
    
    func presentSimilarMovies(movies: [ListMovieProtocol]?) {
        view?.showSimilarMovies(movies: movies)
    }
}
