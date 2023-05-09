//
//  MockDetailPresenter.swift
//  BAZProjectTests
//
//  Created by jehernandezg on 07/05/23.
//

import Foundation
@testable import BAZProject

class MockDetailPresenter: DetailInteractorOutputProtocol {
    var arrSeaerchMovies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Mario Bross", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
    
    func presentDetailMovie(detailMovie: BAZProject.ListMovieProtocol) {
        arrSeaerchMovies[0] = detailMovie
    }
    
    func presentMovies(movies: [BAZProject.ListMovieProtocol]?) {
        arrSeaerchMovies = movies ?? [ListMovieProtocol]()
    }
    
    func presentRecomendations(movies: [BAZProject.ListMovieProtocol]?) {
        arrSeaerchMovies = movies ?? [ListMovieProtocol]()
    }

}
