//  SearchInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import UIKit

// MARK: - Class
class SearchInteractor {
    // MARK: - Properties
    weak var presenter: SearchInteractorOutputProtocol?
    var movies: [ListMovieProtocol]? = []
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
    func getMovieSearch(endPoint: Endpoint) {
        let movieApi = MovieAPI()
        movieApi.fetchData(model: Movie.self, endPoint) { [weak self] result in
            switch result {
            case .failure(let fail):
                print(fail.localizedDescription)
            case .success(let response):
                self?.movies = response.results
                self?.presenter?.presentDataMovies(movies: self?.movies)
            }
        }
    }
    
    /**
     Function that returns a `UIImage` for a specific movie
     - Parameters:
        - index: The index of the url image
        - completion: Returns a UIImage
     - Returns: The image from data.
     - Version: 1.0.0
    */
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if let path = URL(string: "\(MovieAPIConstans.baseUrlImage)\(movies?[index].posterPath ?? "")") ?? URL(string: "") {
            let imageLoader: ImageLoader = ImageLoader()
            imageLoader.loadImage(from: path) { image in
                completion(image)
            }
        }
    }
    
}
