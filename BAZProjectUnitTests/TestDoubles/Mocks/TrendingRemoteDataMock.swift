//
//  TrendingRemoteDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

@testable import BAZProject

class TrendingRemoteDataMock: TrendingMoviesRemoteData {
    
    var movies: [MediaDataObject]?
    var error: Error?
    
    override func getMovies() async throws -> [MediaDataObject]? {
        if let error = error {
            throw error
        } else {
            return movies
        }
    }
    
    override func searchMovies(_ searchText: String) async throws -> [MediaDataObject]? {
        if let error = error {
            throw error
        } else {
            return movies
        }
    }
    
}
