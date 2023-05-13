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

final class MoviesInteractorMock: MoviesInteractorProtocol{
    
    var presenter: BAZProject.MoviesPresenterProtocol?
    var calls: [MoviesInteractorMockCalls] = []
    var fakeMovieApi: FakeMovieApi
    
    init(movieAPI: GenericAPIProtocol) {
        self.fakeMovieApi = movieAPI  as! FakeMovieApi
    }
    
    
    func findMovies(for string: String) {
        presenter?.findMovies(for: string)
        calls.append(.findMovies)
    }
    
    func getMovies(urlRequest: URLRequest) {
        calls.append(.getMovies)
    }
    
    func getLocalMovies() {
        calls.append(.getLocalMovies)
    }
    
}
