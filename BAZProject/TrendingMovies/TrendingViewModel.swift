//
//  TrendingModel.swift
//  BAZProject
//
//  Created by Manuel S on 28/03/23.
//

import Foundation

protocol MoviesListProtocol {
    var movies: [ListMoviesProtocol]? { get set }
    func getmovies(_ Completion: @escaping () -> Void)
    func getMovieCount() -> Int
    func getTitle(index: Int) -> String?
}

class TrendingViewModel: MoviesListProtocol {
   
    var movies: [ListMoviesProtocol]?
    
    func getmovies(_ Completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.getMovies {  moviearray in
            self.movies = moviearray
            Completion()
        }
    }
    
    func getMovieCount() -> Int {
        movies?.count ?? 0
    }
    
    func getTitle(index: Int) -> String? {
        movies?[index].title
    }
    
}




