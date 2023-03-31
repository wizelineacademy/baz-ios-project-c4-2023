//
//  TrendingViewModel.swift
//  BAZProject
//
//  Created by jehernandezg on 30/03/23.
//

import UIKit
import Foundation

protocol MovieListProtocol {
    var movies: [ListMovieProtocol]? { get set }
    func getDataMovies(_ Completion: @escaping () -> Void)
    func getRowCount() -> Int
    func getTitle(index: Int) -> String?
    func getPosterPath(index: Int) -> String?
}

class TrendingViewModel: MovieListProtocol {
    
    var movies: [ListMovieProtocol]?
    
    func getDataMovies(_ Completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.getMovies { [weak self] moviesList in
            self?.movies = moviesList
            Completion()
        }
    }
    
    func getRowCount() -> Int {
        movies?.count ?? 0
    }
    
    func getTitle(index: Int) -> String? {
        movies?[index].title
    }
    
    func getPosterPath(index: Int) -> String? {
        "\(MovieAPIConstans.baseUrlImage)\(movies?[index].poster_path ?? "")"
    }
    
}
