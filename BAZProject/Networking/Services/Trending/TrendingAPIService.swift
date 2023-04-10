//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class TrendingAPIService {

    private let requestHandler = RequestHandler(withSession: URLSession.shared)

    func getMovies(completion: @escaping ([Movie]) -> Void) {
        requestHandler.get(TrendingEndpoint()) { result in
            switch result {
            case .success(let data):
                guard let movies = try? TrendingAPIModel(data: data)?.results else { return }
                completion(movies)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }

}
