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

///Clase mock de MovieDetailInteractor
final class MovieDetailInteractorMock: MoviewDetailInteractorProtocol{
    
    var presenter: BAZProject.MoviewDetailPresenterProtocol?
    
    var calls: [MovieDetailInteractorCalls] = []
    
    ///incializador de  MovieDetailInteractorMock
    /// - parameters:
    ///    - presenter: presenter  con que se inicializa MovieDetailInteractorMock
    init(presenter: BAZProject.MoviewDetailPresenterProtocol? = nil) {
        self.presenter = presenter
    }
    
    ///metodo que llama getSimilar del interactor
    func getSimilar(_ urlRequest: URLRequest) {
        calls.append(.getSimilar)
    }
    
    ///metodo que llama getRecomendation del interactor
    func getRecomendation(_ urlRequest: URLRequest) {
        calls.append(.getRecomendation)
    }
    
    ///metodo que llama getCast del interactor
    func getCast(_ urlRequest: URLRequest) {
        calls.append(.getCast)
    }
    
    ///metodo que llama getReviews del interactor
    func getReviews(_ urlRequest: URLRequest) {
        calls.append(.getReviews)
    }
    
    ///metodo que llama deleteFavorite del interactor
    func deleteFavorite(_ id: Int) {
        calls.append(.deleteFavorite)
    }
    
    ///metodo que llama saveFavorite del interactor
    func saveFavorite(_ movie: BAZProject.ListMovieProtocol) {
        calls.append(.saveFavorite)
    }
    
    ///metodo que llama findFavoriteMovie del interactor
    func findFavoriteMovie(_ id: Int) -> Bool {
        calls.append(.findFavoriteMovie)
        return false
    }
    
    
}
