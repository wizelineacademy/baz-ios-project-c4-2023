//
//  TrendingBarDataManager.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

final class TrendingBarDataManager {
    weak var interactor: TrendingBarRemoteDataOutputProtocol?
    private var service: Service
    
    init(service: Service) {
        self.service = service
    }
}

extension TrendingBarDataManager: TrendingBarRemoteDataInputProtocol {
    func requestTrendingList(_ urlString: String?) {
        service.get(Endpoint.trending) { [weak self] (result: Result<TrendingMoviesResult, Error>) in
            switch result {
            case .success(let trendingList):
                self?.interactor?.handleTrendingFetchedList(trendingList)
            case .failure(let error):
                self?.interactor?.handleService(error: error)
            }
        }
    }
    
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        service.fetchImageData(urlString: urlString, completion: completion)
    }
}
