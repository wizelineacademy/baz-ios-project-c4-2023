//  SearchInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import UIKit

// MARK: - Class
class SearchInteractor {
    // MARK: - Properties
    weak var presenter: SearchInteractorOutputProtocol?
    private(set) var movies: [ListMovieProtocol]? = []
}

// MARK: - Extensions

// MARK: - P R E S E N T E R · T O · I N T E R A C T O R
extension SearchInteractor: SearchInteractorInputProtocol {
    // MARK: - Functions
    /**
     Function that gets an array of movies
     - Parameters:
        - movieName: The movie string to search for
     - Version: 1.0.0
    */
    func getMovieSearch(endPoint: Endpoint, completion: @escaping () -> Void) {
        let apiMovie = MovieAPI()
        apiMovie.fetchData(model: Movie.self, endPoint) { [weak self] objResult in
            switch objResult {
            case .failure(let fail):
                print(fail.localizedDescription)
            case .success(let objResponse):
                self?.movies = objResponse.results
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
