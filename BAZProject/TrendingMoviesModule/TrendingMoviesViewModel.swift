//
//  TrendingMoviesViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMoviesViewModel {
    
    var movies = Box([Movie]())
    var remoteData: TrendingMoviesRemoteData
    
    init(movies: [Movie] = [], remoteData: TrendingMoviesRemoteData) {
        self.movies.value = movies
        self.remoteData = remoteData
    }
    
    func bindMovies(_ handler: @escaping () -> Void) {
        movies.bind(handler)
    }
    
    func getMovies() async throws {
        movies.value = try await remoteData.getMovies() ?? []
    }
    
    func getCellConfiguration(row: Int) -> UIListContentConfiguration {
        var configuration = UIListContentConfiguration.cell()
        let movie = movies.value[row]
        configuration.text = movie.title
        return configuration
    }
    
    func getRowCount() -> Int {
        return movies.value.count
    }
    
}
