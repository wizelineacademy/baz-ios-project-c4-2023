//
//  TrendingRemoteDataManagerMock.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 25/04/23.
//

import XCTest
@testable import BAZProject

class TrendingRemoteDataManagerMock: TrendingRemoteDataManagerInputProtocol {
    func getMoviesTrending() {
        //<#code#>
    }
    
    func getNowPlaying() {
        //<#code#>
    }
    
    func getPopular() {
        //<#code#>
    }
    
    func getTopRated() {
        //<#code#>
    }
    
    func getUpcoming() {
        //<#code#>
    }
    
    var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol?
    
    func getMovies() {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinatorMock(session: session)
        coordinator.fileName = "TrendingApiMock.json"
                
        coordinator.get(.generic){(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                self.remoteRequestHandler?.handleGetMovies(trendingMovies.results)
                case .failure(let error):
                print(error.localizedDescription.description)
            }
        }
    }
    
    
}
