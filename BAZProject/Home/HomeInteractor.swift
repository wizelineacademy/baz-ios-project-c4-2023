//  HomeInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

// MARK: - Class
class HomeInteractor {
    // MARK: - Properties
    weak var presenter: HomeInteractorOutputProtocol?
    private(set) var movies: [ListMovieProtocol]? = []
}

// MARK: - Extensions

// MARK: - P R E S E N T E R · T O · I N T E R A C T O R
extension HomeInteractor: HomeInteractorInputProtocol {
    // MARK: - Functions
    /**
     Function that gets an array of movies
     - Version: 1.0.0
    */
    func getDataMovies(endPoint: Endpoint, completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.fetchData(model: Movie.self, endPoint) { [weak self] result in
            switch result {
            case .failure(let fail):
                completion()
                print(fail.localizedDescription)
            case .success(let response):
                self?.movies = response.results
                guard let favorites = self?.getFavorites(), let origin = self?.movies else {
                    self?.presenter?.presentDataMovies(movies: self?.movies)
                    completion()
                    return
                }
                for i in 0..<origin.count {
                    for j in 0..<favorites.count {
                        if origin[i].id == favorites[j].id {
                            self?.movies?[i].isFavorite = true
                        }
                    }
                }
                self?.presenter?.presentDataMovies(movies: self?.movies)
                completion()
            }
        }
    }
    
}
