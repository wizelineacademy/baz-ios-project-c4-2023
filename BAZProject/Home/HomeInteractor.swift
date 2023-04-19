//  HomeInteractor.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.
//  
//  ViperTemplate v.0.0.1 - (2023, NS-Bionick Development Team)

import UIKit

// MARK: - Class
class HomeInteractor {
    // MARK: - Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var movies: [ListMovieProtocol]? = []
}

// MARK: - Extensions
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
    }
    
    func getDataMovies(_ completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.fetchData(model: Movie.self, urlPath: "\(MovieAPIConstans.baseURL)\(MovieAPIConstans.trending)\(MovieAPIConstans.apiKey)") { [weak self] result in
            switch result {
            case .failure(let fail):
                print(fail)
            case .success(let response):
                self?.movies = response.results
                completion()
            }
        }
    }
    
    var labelTitle: String {
        return "string label title"
    }
    
    
}
