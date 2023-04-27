//
//  DetailInteractor.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation

public protocol DetailBusinessLogic {
    var presenter: DetailPresentationLogic? { get }
    
    func getCurrentData()
    func searchForSimilar()
}

public class DetailInteractor {
    public var presenter: DetailPresentationLogic?
    public var entity: DetailInfo?
    public var networking: NetworkingProtocol?
    
    public init(presenter: DetailPresentationLogic? = nil, entity: DetailInfo? = nil) {
        self.presenter = presenter
        self.entity = entity
    }
    
    public func setUpEntity(withMovie movie: Movie) {
        entity = nil
        entity = DetailInfo(movie: movie)
    }
}

extension DetailInteractor: DetailBusinessLogic {
    public func getCurrentData() {
        presenter?.currentInfo(movie: entity?.movie)
    }
    
    public func searchForSimilar() {
        guard let iMovieId = entity?.movie.id else {
            presenter?.serviceDidFailed(with: .badParameter)
            return
        }
        networking?.updatePath(with: .similarMovies(strMovieId: "\(iMovieId)"))
        networking?.search(withCompletionHandler: { [weak self] (result: Result<MovieService, ErrorApi>) in
            switch result {
            case .failure(let error):
                self?.presenter?.serviceDidFailed(with: error)
            case .success(let result):
                self?.handelSuccess(with: result.results)
            }
        })
    }
    
    private func handelSuccess(with arrResponse: [MovieDetailService]?) {
        entity?.updateSimilarArray(with: arrResponse)
        if let arrMovieSimilar = entity?.arrSimilar {
            presenter?.similarMoviewsObtained(with: arrMovieSimilar)
        }
    }
    
}
