//
//  TrendingRemoteDataMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

@testable import BAZProject

class TrendingRemoteDataMock: TrendingMoviesRemoteData {
    
    override func getMovies() async throws -> [Movie]? {
        return nil
    }
    
    override func searchMovies(_ searchText: String) async throws -> [Movie]? {
        return nil
    }
    
}
