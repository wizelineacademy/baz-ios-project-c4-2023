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
    func getMovieSearch(movieName: String) {
        let movieApi = MovieAPI()
        let path = "\(MovieAPIConstans.baseURL)\(MovieAPIConstans.search)\(MovieAPIConstans.apiKey)\(MovieAPIConstans.searchConfig)\(movieName)"
        let newPath = path.replacingOccurrences(of: " ", with: "%20")
        movieApi.fetchData(model: Movie.self, urlPath: newPath) { [weak self] result in
            switch result {
            case .failure(let fail):
                print(fail.localizedDescription)
            case .success(let response):
                self?.movies = response.results
                self?.presenter?.presentDataMovies(movies: self?.movies)
            }
        }
    }
    
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        if let path = URL(string: "\(MovieAPIConstans.baseUrlImage)\(movies?[index].posterPath ?? "")") ?? URL(string: "") {
            let imageLoader: ImageLoader = ImageLoader()
            imageLoader.loadImage(from: path) { image in
                completion(image)
            }
        } else {
            completion(nil)
        }
    }
    
}
