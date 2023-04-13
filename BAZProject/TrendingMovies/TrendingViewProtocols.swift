//
//  TrendingViewProtocols.swift
//  BAZProject
//
//  Created by Manuel S on 10/04/23.
//

import Foundation

protocol MoviesListProtocol {
    var movies: [ListMoviesProtocol]? { get set }
    func getmovies(_ Completion: @escaping () -> Void)
    func getMovieCount() -> Int
    func getTitle(index: Int) -> String?
}
