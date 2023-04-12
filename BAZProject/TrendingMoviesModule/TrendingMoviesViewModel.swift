//
//  TrendingMoviesViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMoviesViewModel {
    
    var movies = [Movie]()
    var remoteData: TrendingMoviesRemoteData
    
    init(movies: [Movie] = [], remoteData: TrendingMoviesRemoteData) {
        self.movies = movies
        self.remoteData = remoteData
    }
    
    func getMovies() async throws {
        movies = try await remoteData.getMovies() ?? []
    }
    
    func getCellConfiguration(row: Int) -> UIListContentConfiguration {
        var configuration = UIListContentConfiguration.cell()
        let movie = movies[row]
        configuration.text = movie.title
        return configuration
    }
    
    func getRowCount() -> Int {
        return movies.count
    }
    
}
