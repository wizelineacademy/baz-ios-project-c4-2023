//
//  TrendingViewModel.swift
//  BAZProject
//
//  Created by jehernandezg on 30/03/23.
//

import UIKit

/// Protocol that is responsible for having the logic of movies to be called in the view
protocol MovieListProtocol {
    var movies: [ListMovieProtocol]? { get set }
    func getDataMovies(_ completion: @escaping () -> Void)
    func getRowCount() -> Int
    func getTitle(index: Int) -> String?
    func getPosterPath(index: Int) -> String?
    func getRemoteImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

/// Structure that conforms to the MovieListProtocol protocol
final class TrendingViewModel: MovieListProtocol {
    
    var movies: [ListMovieProtocol]? = []
    
    func getDataMovies(_ completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.getMovies { [weak self] moviesList in
            self?.movies = moviesList
            completion()
        }
    }
    
    func getRowCount() -> Int {
        movies?.count ?? 0
    }
    
    func getTitle(index: Int) -> String? {
        movies?[index].title
    }
    
    func getPosterPath(index: Int) -> String? {
        "\(MovieAPIConstans.baseUrlImage)\(movies?[index].posterPath ?? "")"
    }
    
    func getRemoteImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let imageLoader: ImageLoader = ImageLoader()
        imageLoader.loadImage(from: url) { [weak self] image in
            completion(image)
        }
    }
    
}
