//
//  DetailsViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 26/04/23.
//

import Foundation

class DetailsViewModel {
    
    var movieDetail: Box<ListMoviesProtocol>
    
    init(movieDetail: ListMoviesProtocol) {
        self.movieDetail = Box(value: movieDetail)
    }
    
    

}
