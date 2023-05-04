//
//  MovieApiMock.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import Foundation

final class MovieApiMock: MovieAPI {
    
    var movies = [InfoMoviesProtocol]()
    var cast = [CastInfoProtocol]()
    var error: Error?
    
    override func getMovies(category: categoriesFilter , idMovie: Int = 0,  completion: @escaping ([InfoMoviesProtocol], Error?) -> Void) {
        completion(movies, error)
    }
    
    override func getCast(idMovie: Int = 0 , completion: @escaping ([CastInfoProtocol], Error?) -> Void) {
        completion(cast, error)
    }
}
