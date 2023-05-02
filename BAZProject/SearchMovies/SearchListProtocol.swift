//
//  SearchListProtocol.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import Foundation


protocol SearchListProtocol {
    
    var moviesSearched: Box<[InfoMoviesProtocol]> { get set }

    //MARK: - Funciones para la vista
    func bindMovies(_ listener: @escaping () -> Void)
    func getMovieCount() -> Int
    func getTitle(index: Int) -> String?
    func cleanMoviesArray()
    func getImagePath(index: Int) -> String?
    func getAllInfoMoview(index: Int) -> InfoMoviesProtocol
    func searchMovie(_ title: String, apiKey: String, completion: @escaping (Error?) -> Void)
}
