//
//  MovieDetailInteractor.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import Foundation
@testable import BAZProject

enum MovieDetailInteractorCalls{
    case getSimilar
    case getRecomendation
    case getCast
    case getReviews
    case saveFavorite
    case findFavoriteMovie
    case deleteFavorite
}

final class MovieDetailInteractorMock: MoviewDetailInteractorProtocol{
    var presenter: BAZProject.MoviewDetailPresenterProtocol?
    var calls: [MovieDetailInteractorCalls] = []
    
    init(presenter: BAZProject.MoviewDetailPresenterProtocol? = nil) {
        self.presenter = presenter
    }
    
    
    func getSimilar(_ id: String) {
        calls.append(.getSimilar)
    }
    
    func getRecomendation(_ id: String) {
        calls.append(.getRecomendation)
    }
    
    func getCast(_ id: String) {
        calls.append(.getCast)
    }
    
    func deleteFavorite(_ id: Int) {
        calls.append(.deleteFavorite)
    }
    
    func getReviews(_ id: String) {
        calls.append(.getReviews)
    }
    
    func saveFavorite(_ movie: BAZProject.ListMovieProtocol) {
        calls.append(.saveFavorite)
    }
    
    func findFavoriteMovie(_ id: Int) -> Bool {
        calls.append(.findFavoriteMovie)
        return false
    }
    
    
}
