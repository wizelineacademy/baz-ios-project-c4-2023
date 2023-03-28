//
//  TrendingBarInteractorMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import Foundation
@testable import BAZProject

enum TrendingBarInteractorMockCalls {
    case fetchMovieList
    case fetchImageFrom
    case handleTrendingFetchedList
    case handleServiceError
}

final class TrendingBarInteractorMock: TrendingBarInteractorInputProtocol, TrendingBarRemoteDataOutputProtocol {
    var presenter: TrendingBarInteractorOutputProtocol?
    var remoteData: TrendingBarRemoteDataInputProtocol?
    var calls: [TrendingBarInteractorMockCalls] = []
    var catchedError: ServiceError?
    
    func fetchMovieList(_ endPoint: Endpoint) {
        calls.append(.fetchMovieList)
    }
    
    func fetchImageFrom(_ movie: MovieResult) {
        calls.append(.fetchImageFrom)
    }
    
    func handleTrendingFetchedList(_ trendingList: TrendingMoviesResult) {
        calls.append(.handleTrendingFetchedList)
    }
    
    func handleService(error: Error) {
        self.catchedError = (error as? ServiceError)
        calls.append(.handleServiceError)
    }
}
