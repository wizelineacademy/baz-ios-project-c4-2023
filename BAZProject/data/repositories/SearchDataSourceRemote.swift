//
//  SearchDataSourceRemote.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 27/04/23.
//

import Foundation

class SearchDataSourceRemote: SearchRepository {

    private let movieApi = MovieAPI()

    func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {
        movieApi.searchMoviesForKeyword(query) { movies in
            completion(movies)
        }
    }

    func searchKeyword(query: String, completion: @escaping ([String]) -> Void) {
        movieApi.searchForKeyword(query) { keywords in
            completion(keywords)
        }
    }
}
