//
//  MovieApiMock.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 31/03/23.
//

import Foundation

class MovieApiMock: MovieDataProvider {
    
    func getMovies(completion handler: @escaping ([Movie]) -> Void) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinatorMock(session: session)
        coordinator.fileName = "TrendingApiMock.json"
                
        coordinator.get{(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                handler(trendingMovies.results)
                case .failure(let error):
                print(error.localizedDescription.description)
            }
        }
    }
}
