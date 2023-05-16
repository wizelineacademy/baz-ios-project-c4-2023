//
//  TrendingMoviesInteractorMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum MoviesInteractorMockCalls{
    case getMovies
    case getRemotImage
    case findMovies
    case getLocalMovies
}

///Clase mock de MovieDetailInteractor
final class MoviesInteractorMock: MoviesInteractorProtocol{
    
    var presenter: BAZProject.MoviesPresenterProtocol?
    var calls: [MoviesInteractorMockCalls] = []
    var fakeMovieApi: FakeMovieApi
    
    
    ///incializador de  MovieDetailInteractorMock
    /// - parameters:
    ///    - movieAPI: movieAPI  con que se inicializa MovieDetailInteractorMock
    init(movieAPI: GenericAPIProtocol) {
        self.fakeMovieApi = movieAPI  as! FakeMovieApi
    }
    
    ///metodo que llama findMovies del interactor
    func findMovies(for string: String) {
        presenter?.findMovies(for: string)
        calls.append(.findMovies)
    }
    
    ///metodo que llama findMovies del interactor
    func getMovies(urlRequest: URLRequest) {
        calls.append(.getMovies)
    }
    
    ///metodo que llama findMovies del interactor
    func getLocalMovies() {
        calls.append(.getLocalMovies)
    }
    
}
