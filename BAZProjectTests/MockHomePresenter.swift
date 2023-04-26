//
//  MockHomePresenter.swift
//  BAZProjectTests
//
//  Created by jehernandezg on 21/04/23.
//

import Foundation
@testable import BAZProject

class MockHomePresenter: HomeInteractorOutputProtocol {
    var arrMovies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Dragon Ball", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]

    func presentDataMovies(movies: [BAZProject.ListMovieProtocol]?) {
        arrMovies = movies ?? [ListMovieProtocol]()
    }
}
