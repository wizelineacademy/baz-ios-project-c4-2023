//
//  DetailInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

// MARK: - Class
class DetailInteractor {
    // MARK: - Properties
    weak var presenter: DetailInteractorOutputProtocol?
    var movies: [ListMovieProtocol]? = []
    var recomendations: [ListMovieProtocol]? = []
}

// MARK: - Extensions

// MARK: - P R E S E N T E R · T O · I N T E R A C T O R
extension DetailInteractor: DetailInteractorInputProtocol {
    // MARK: - Functions
    
    /// Function that returns a `UIImage` of the selected movie
    /// - Parameter detailMovie: The data of the selected movie
    /// - Version: 1.0.0
    func getDetailMovie(detailMoviePI detailMovie: ListMovieProtocol) {
        presenter?.presentDetailMovie(detailMovie: detailMovie)
    }
    
    func getMovies(endPoint: Endpoint, completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.fetchData(model: Movie.self, endPoint) { [weak self] result in
            switch result {
            case .failure(_):
                completion()
            case .success(let response):
                self?.movies = response.results
                self?.presenter?.presentMovies(movies: self?.movies)
                completion()
            }
        }
    }
    
    func getRecomendations(endPoint: Endpoint, completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.fetchData(model: Movie.self, endPoint) { [weak self] result in
            switch result {
            case .failure(_):
                completion()
            case .success(let response):
                self?.recomendations = response.results
                self?.presenter?.presentRecomendations(movies: self?.recomendations)
                completion()
            }
        }
    }
    
}

