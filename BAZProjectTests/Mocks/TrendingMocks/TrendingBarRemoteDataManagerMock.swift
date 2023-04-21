//
//  TrendingBarRemoteDataManagerMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import Foundation
@testable import BAZProject

enum TrendingBarRemoteDataManagerCalls {
    case requestMovieList
    case requestImageData
}

final class TrendingBarRemoteDataManagerMock: TrendingBarRemoteDataInputProtocol {
    var interactor: TrendingBarRemoteDataOutputProtocol?
    var calls: [TrendingBarRemoteDataManagerCalls] = []
    
    func requestMovieList(byEndPoint endPoint: BAZProject.EndPointProtocol) {
        calls.append(.requestMovieList)
    }
    
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        calls.append(.requestImageData)
    }
}
