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
    
    func getRemotImage(from stringURL: String, completion: @escaping (UIImage?) -> ()) {
        calls.append(.getRemotImage)
        guard let url = URL(string: ApiConstans.baseUrlImage + stringURL) else { return }
        UIImage().loadFrom(url: url, completion: completion)
    }
    
    func findMovies(for string: String, completion: @escaping ([BAZProject.ListMovieProtocol]) -> ()) {
        calls.append(.findMovies)
        guard let request = getSearchMoviewUrlRequest(searchString: string) else { return }
        fakeMovieApi.fetch(request: request) { (result: Result<MovieResult?, Error>) in
            switch result {
            case .failure(let fail):
                print(fail)
            case .success(let response):
                guard let movies = response?.results else { return }
                completion(movies)
            }
        }
    }
}
