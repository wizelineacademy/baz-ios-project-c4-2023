//
//  TrendingModel.swift
//  BAZProject
//
//  Created by Manuel S on 28/03/23.
//

import Foundation

class TredingViewViewModel {
        
    func getmovies(_ contiue: @escaping ([ListMoviesProtocol]) -> Void) {
        let movieApi = MovieAPI()
        movieApi.getMovies {  moviearray in
            contiue(moviearray)
        }
    }
    
}
