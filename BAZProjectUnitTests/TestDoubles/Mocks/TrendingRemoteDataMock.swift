//
//  TrendingRemoteDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

@testable import BAZProject

class TrendingRemoteDataMock: TrendingMoviesRemoteData {
    
    var movies: [Movie]?
    var error: Error?
    
    override func getMovies() async throws -> [Movie]? {
        if let error = error {
            throw error
        } else {
            return movies
        }
    }
    
    override func searchMovies(_ searchText: String) async throws -> [Movie]? {
        if let error = error {
            throw error
        } else {
            return movies
        }
    }
    
}
