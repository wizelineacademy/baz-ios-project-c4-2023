//
//  MovieDetailInteractor.swift
//  BAZProject
//
//  Created by 989438 on 27/04/23.
//

import Foundation

final class MovieDetailInteractor {
    weak var presenter: MovieDetailInteractorOutputProtocol?
    var remoteData: MovieDetailRemoteDataInputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    func fetchForActors(_ endPoint: EndPointProtocol) {
        remoteData?.requestActors(withEndPoint: endPoint)
    }
    
    func fetchForSimilarMovies(_ endPoint: EndPointProtocol) {
        remoteData?.requestSimilarMovies(withEndPoint: endPoint)
    }
    
    func fetchForRecommendedMovies(_ endPoint: EndPointProtocol) {
        remoteData?.requestRecommendedMovies(withEndPoint: endPoint)
    }
    
    func fetchUserReviews(_ endPoint: EndPointProtocol) {
        remoteData?.requestUserReviews(withEndPoint: endPoint)
    }
    
    func fetchMovieBanner(_ urlString: String) {
        remoteData?.requestImageData(urlString: "\(EndPointConstants.mediaEndPoint)\(urlString)", completion: { [weak self] data in
            guard let imageData = data else { return }
            self?.presenter?.onReceivedMovieBanner(with: imageData)
        })
    }
    
    func fetchSimilarImageFrom(_ movies: [MovieResult]) {
        remoteData?.requestMoviesImageData(movies: movies, completion: { [weak self] movieModelArray in
            self?.presenter?.onReceivedSimilarMoviesModel(with: movieModelArray)
        })
    }
    
    func fetchRecommendedImageFrom(_ movies: [MovieResult]) {
        remoteData?.requestMoviesImageData(movies: movies, completion: { [weak self] movieModelArray in
            self?.presenter?.onReceivedRecommendedMoviesModel(with: movieModelArray)
        })
    }
    
    func fetchImageProfile(_ actors: [Actor]) {
        remoteData?.requestProfileImageData(actors: actors, completion: { [weak self] actorModelArray in
            self?.presenter?.onReceivedActorModel(withActorModel: actorModelArray)
        })
    }
    
    func fetchUserAvatar(_ reviews: [Review]) {
        remoteData?.requestUserImageData(reviews: reviews, completion: { [weak self] reviewModelArray in
            self?.presenter?.onReceivedUserReviewModel(with: reviewModelArray)
        })
    }
}

extension MovieDetailInteractor: MovieDetailRemoteDataOutputProtocol {
    func handleActorsFetchedList(_ actorList: MovieCast) {
        presenter?.onReceivedActors(with: actorList)
    }
    
    func handleSimilarMoviesFetchedList(_ movieList: MoviesResult) {
        presenter?.onReceivedSimilarMovies(with: movieList)
    }
    
    func handleRecommendedMoviesFetchedList(_ movieList: MoviesResult) {
        presenter?.onReceivedRecommendedMovies(with: movieList)
    }
    
    func handleUserReviewsFetchedList(_ reviewList: ReviewResponse) {
        presenter?.onReceivedUserReviews(with: reviewList)
    }
    
    func handleService(error: Error) {
        presenter?.onReceived(with: error)
    }
}
