//
//  SearchMovieDataManager.swift
//  BAZProject
//
//  Created by 989438 on 18/04/23.
//

import Foundation

final class MovieSearchDataManager {
    weak var interactor: MovieSearchRemoteDataOutputProtocol?
    private var service: Service
    
    init(service: Service) {
        self.service = service
    }
}

extension MovieSearchDataManager: MovieSearchRemoteDataInputProtocol {
    func requestSearchMovie(byEndPoint endPoint: EndPointProtocol) {
        service.get(endPoint) { [weak self] (result: Result<MoviesResult, Error>) in
            switch result {
            case .success(let movieList):
                self?.interactor?.handleSearchingFetchedList(movieList)
            case .failure(let error):
                self?.interactor?.handleService(error: error)
            }
        }
    }
    
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        service.fetchImageData(urlString: urlString, completion: completion)
    }
}
