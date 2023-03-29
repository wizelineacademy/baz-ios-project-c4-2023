//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class TrendingAPIService {

    private let requestHandler = RequestHandler()

    func getMovies(completion: @escaping ([Movie]) -> Void) {
        requestHandler.get(.trending) { (result: Result<TrendingAPIModel , RequestHandlerError>) in
            switch result {
            case .success(let data): completion(data.results)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }

}
