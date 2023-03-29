//
//  TrendingMoviesModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import UIKit

class TrendingMoviesModel {
    var movies: [Movie]?
    
    func getMovies(completion: @escaping () -> Void ) {
        TrendingAPIService().getMovies { [weak self] movies in
            self?.movies = movies
            completion()
        }
    }
    
    func getCellConfiguration(row: Int) -> UIListContentConfiguration {
        var configuration = UIListContentConfiguration.cell()
        if let movie = movies?[row] {
            configuration.text = movie.title
        }
        return configuration
    }
}
