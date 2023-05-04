//
//  TrendingMoviesInteractorMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum TrendingMoviesInteractorMockCalls{
    case getMovies
    case getRemotImage
    case findMovies
}

final class TrendingMoviesInteractorMock: TrendingMoviesInteractorProtocol{
    
    var presenter: BAZProject.TrendingMoviesPresenterProtocol?
    var calls: [TrendingMoviesInteractorMockCalls] = []
    var fakeMovieApi: FakeMovieApi
    
    init(movieAPI: GenericAPIProtocol) {
        self.fakeMovieApi = movieAPI  as! FakeMovieApi
    }
    
    func getMovies() {
        calls.append(.getMovies)
    }
    
    func findMovies(for string: String) {
        presenter?.findMovies(for: string)
        calls.append(.findMovies)
    }
}
