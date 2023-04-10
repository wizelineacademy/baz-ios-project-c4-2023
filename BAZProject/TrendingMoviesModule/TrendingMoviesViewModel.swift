//
//  TrendingMoviesViewModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMoviesViewModel {
    
    var movies = [Movie]()
    
    func getMovies() async throws {
        movies = try await TrendingMoviesRemoteData().getMovies() ?? []
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
