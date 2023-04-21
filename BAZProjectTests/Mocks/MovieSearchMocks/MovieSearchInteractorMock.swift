//
//  MovieSearchInteractorMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import Foundation
@testable import BAZProject

enum MovieSearchInteractorMockCalls {
    case fetchSearchMovieResults
    case fetchImageFrom
    case handleSearchingFetchedList
    case handleServiceError
}

final class MovieSearchInteractorMock: MovieSearchInteractorInputProtocol, MovieSearchRemoteDataOutputProtocol {
    var presenter: BAZProject.MovieSearchInteractorOutputProtocol?
    var remoteData: BAZProject.MovieSearchRemoteDataInputProtocol?
    var calls: [MovieSearchInteractorMockCalls] = []
    var catchedError: ServiceError?
    var imgData: Data?
    
    func fetchSearchMovieResults(_ endPoint: BAZProject.EndPointProtocol) {
        calls.append(.fetchSearchMovieResults)
    }
    
    func fetchImageFrom(_ movie: BAZProject.MovieResult) {
        remoteData?.requestImageData(urlString: "", completion: { [weak self] data in
            self?.imgData = data
        })
        calls.append(.fetchImageFrom)
    }
    
    func handleSearchingFetchedList(_ movieList: BAZProject.MoviesResult) {
        calls.append(.handleSearchingFetchedList)
    }
    
    func handleService(error: Error) {
        catchedError = (error as? ServiceError)
        calls.append(.handleServiceError)
    }
}
