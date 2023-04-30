//
//  TrendingViewProtocols.swift
//  BAZProject
//
//  Created by Manuel S on 10/04/23.
//

import Foundation

protocol TrendingListProtocol {
    var movies: Box<[InfoMoviesProtocol]> { get set }
    func getmovies(category: categoriesFilter)
    func getMovieCount() -> Int
    func getTitle(index: Int) -> String?
    func bindMovies(_ listener: @escaping () -> Void)
    func getPathImage(index: Int) -> String?
    func getAllInfoMoview(index: Int) -> InfoMoviesProtocol
}
