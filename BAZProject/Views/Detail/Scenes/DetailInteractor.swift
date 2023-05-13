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
    func buttonWasTouched()
}

public class DetailInteractor {
    public var presenter: DetailPresentationLogic?
    public var entity: DetailInfo?
    public var networking: NetworkingProtocol?
    public var favorite: FavoriteSavingManager?
    public var bIsFavorite: Bool = false
    
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
        guard let iMovieId = entity?.movie.id else {
            presenter?.serviceDidFailed(with: .badParameter)
            return
        }
        bIsFavorite = favorite?.movieIsFavorite(entity?.movie) ?? false
        presenter?.currentInfo(movie: entity?.movie, isFavorite: bIsFavorite)
        searchForCast(forMovie: iMovieId)
        searchForReview(forMovie: iMovieId)
        searchForSimilar(forMovie: iMovieId)
    }
    
    public func buttonWasTouched() {
        favorite?.handle(movie: entity?.movie, isFavorite: bIsFavorite)
        bIsFavorite = favorite?.movieIsFavorite(entity?.movie) ?? false
        presenter?.currentInfo(movie: entity?.movie, isFavorite: bIsFavorite)
    }
    
    private func searchForSimilar(forMovie iMovieId: Int) {
        networking?.updatePath(with: .similarMovies(strMovieId: "\(iMovieId)"))
        networking?.search(withCompletionHandler: { [weak self] (result: Result<MovieService<MovieDetailService>, ErrorApi>) in
            switch result {
            case .failure(let error):
                self?.presenter?.serviceDidFailed(with: error)
            case .success(let result):
                self?.handelSuccess(with: result.results)
            }
        })
    }
    
    private func searchForReview(forMovie iMovieId: Int) {
        networking?.updatePath(with: .review(strMovieId: "\(iMovieId)"))
        networking?.search(withCompletionHandler: { [weak self] (result: Result<MovieService<ReviewService>, ErrorApi>) in
            switch result {
            case .success(let success):
                self?.handleSuccessReview(with: success.results)
            case .failure(let failure):
                self?.presenter?.serviceDidFailed(with: failure)
            }
        })
    }
    
    private func searchForCast(forMovie iMovieId: Int) {
        networking?.updatePath(with: .cast(strMovieId: "\(iMovieId)"))
        networking?.search(withCompletionHandler: { [weak self] (result: Result<CastResults, ErrorApi>) in
            switch result {
            case .success(let success):
                self?.handleSuccessCast(with: success.cast)
            case .failure(let failure):
                self?.presenter?.serviceDidFailed(with: failure)
            }
        })
    }
    
    private func handelSuccess(with arrResponse: [MovieDetailService]?) {
        entity?.updateSimilarArray(with: arrResponse)
        if let arrMovieSimilar = entity?.arrSimilar {
            presenter?.similarMoviewsObtained(with: arrMovieSimilar)
        }
    }
    
    public func handleSuccessReview(with arrResponse: [ReviewService]?) {
        entity?.updateReviewArray(with: arrResponse)
        if let arrReview = entity?.arrReviews {
            presenter?.reviewsWereObtained(with: arrReview)
        }
    }
    
    private func handleSuccessCast(with arrResponse: [CastService]?) {
        entity?.updateCast(with: arrResponse)
        if let arrCast = entity?.arrCast {
            presenter?.castobtained(with: arrCast)
        }
    }
}
