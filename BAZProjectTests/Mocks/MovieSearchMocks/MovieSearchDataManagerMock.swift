//
//  MovieSearchDataManagerMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import Foundation
@testable import BAZProject

enum MovieSearchDataManagerMockCalls {
    case requestSearchMovie
    case requestImageData
}

final class MovieSearchDataManagerMock: MovieSearchRemoteDataInputProtocol {
    var interactor: BAZProject.MovieSearchRemoteDataOutputProtocol?
    var calls: [MovieSearchDataManagerMockCalls] = []
    
    func requestSearchMovie(byEndPoint endPoint: BAZProject.EndPointProtocol) {
        calls.append(.requestSearchMovie)
    }
    
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        calls.append(.requestImageData)
    }
}
