//
//  TrendingRemoteDataManager.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation

class TrendingRemoteDataManager: TrendingRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol?
    var serviceApi: NetworkingProtocol?
    
    func getMovies() {
        serviceApi?.search()
    }
    
}

extension TrendingRemoteDataManager: ServiceApiProtocol {
    func serviceFinished(withResult result: Result<[String : Any], ErrorApi>) {
        DispatchQueue.main.async{[weak self] in
            switch result {
            case .success(let success):
                self?.remoteRequestHandler?.moviesObtained(with: self?.parse(response: success))
            case .failure(let failure):
                self?.remoteRequestHandler?.serviceDidFail(with: failure)
            }
        }
    }
    
    private func parse(response dctResponse: [String : Any]) -> [Movie]? {
        var arrMovies: [Movie] = [Movie]()
        guard let results = dctResponse["results"] as? [[String : Any]] else { return nil }
        for result in results {
            if let id = result["id"] as? Int,
               let title = result["title"] as? String,
               let poster_path = result["poster_path"] as? String {
                arrMovies.append(Movie(id: id, title: title, poster_path: poster_path))
            }
        }
        return arrMovies
    }
}
