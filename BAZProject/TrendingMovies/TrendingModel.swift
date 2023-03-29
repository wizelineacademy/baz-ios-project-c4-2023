//
//  TrendingModel.swift
//  BAZProject
//
//  Created by Manuel S on 28/03/23.
//

import Foundation

class myTredingModel {
    
    var myTredingMoviesArray: [Movie] = []
    
    func getmovies(_ contiue: @escaping ([Movie]) -> Void) {
        let movieApi = MovieAPI()
        movieApi.getMovies { [weak self] moviearray in
            self?.myTredingMoviesArray = moviearray
            contiue(self?.myTredingMoviesArray ?? [])
        }
    }
    
}
