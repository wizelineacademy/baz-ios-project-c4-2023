//  HomeInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

// MARK: - Class
class HomeInteractor {
    // MARK: - Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var movies: [ListMovieProtocol]? = []
}

// MARK: - Extensions

// MARK: - P R E S E N T E R · T O · I N T E R A C T O R
extension HomeInteractor: HomeInteractorInputProtocol {
        
    // MARK: - Functions
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
    
    func getDataMovies() {
        let movieApi = MovieAPI()
        movieApi.fetchData(model: Movie.self, urlPath: "\(MovieAPIConstans.baseURL)\(MovieAPIConstans.search)\(MovieAPIConstans.apiKey)\(MovieAPIConstans.searchKeyWord)"
            /*"\(MovieAPIConstans.baseURL)\(MovieAPIConstans.trending)\(MovieAPIConstans.apiKey)"*/) { [weak self] result in
            switch result {
            case .failure(let fail):
                print(fail.localizedDescription)
            case .success(let response):
                self?.movies = response.results
                self?.presenter?.presentDataMovies(movies: self?.movies)
            }
        }
    }
    
    var labelTitle: String {
        "Home"
    }
    
}
