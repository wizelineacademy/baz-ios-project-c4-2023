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
    func getMovieDescription(index: Int) -> String? {
        movies?[index].title
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
    
    func getMoviesCount() -> Int {
        movies?.count ?? 0
        //self.presenter?.presentMoviesCount(count: rowCount)
    }
    
    func getDataMovies() {
        let movieApi = MovieAPI()
        movieApi.fetchData(model: Movie.self, urlPath: /*"\(MovieAPIConstans.baseURL)\(MovieAPIConstans.search)\(MovieAPIConstans.apiKey)\(MovieAPIConstans.searchKeyWord)"*/
            "\(MovieAPIConstans.baseURL)\(MovieAPIConstans.trending)\(MovieAPIConstans.apiKey)") { [weak self] result in
            switch result {
            case .failure(let fail):
                print(fail)
            case .success(let response):
                self?.movies = response.results
                self?.presenter?.presentDataMovies(movies: self?.movies)
            }
        }
    }
    
    var labelTitle: String {
        return "string label title"
    }
    
}
