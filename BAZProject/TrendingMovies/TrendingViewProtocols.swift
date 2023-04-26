//
//  TrendingViewProtocols.swift
//  BAZProject
//
//  Created by Manuel S on 10/04/23.
//

import Foundation

protocol MoviesListProtocol {
    var movies: Box<[ListMoviesProtocol]> { get set }
    func getmovies(category: categoriesFilter)
    func getMovieCount() -> Int
    func getTitle(index: Int) -> String?
    func bindMovies(_ listener: @escaping () -> Void)
}
