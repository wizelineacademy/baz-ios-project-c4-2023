//
//  MoviesDetailInteractor.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import Foundation
final class MoviesDetailInteractor {
    
    // MARK: Properties
    weak var presenter  : MoviesDetailInteractorOutputProtocol?
    
    var movieApi        : Service
    var moviesInfo      : MovieData?
    
    init(movieApi: Service, moviesInfo: MovieData?) {
        self.movieApi   = movieApi
        self.moviesInfo = moviesInfo
    }
    
}
// MARK: Extension
extension MoviesDetailInteractor: MoviesDetailInteractorInputProtocol{
    
    func getReview() {
        movieApi.getMovies(OptionMovie.getReviews(moviesInfo?.id ?? 0).request){ [weak self] (result: Result< MovieDetailResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let moviesReponse):
                    if moviesReponse.movies?.count ?? 0 > 0{
                        self?.setReviews(with: moviesReponse.movies)
                    }else{
                        self?.presenter?.setError()
                    }
                default:
                    self?.presenter?.setError()
                }
            }
        }
    }
    
    func setReviews(with resultDetailReview: [MovieDetail]?){
        var detailReviews              : [ReviewsMovieData] = []
        for resultDetailReviews in resultDetailReview ?? [MovieDetail](){
            detailReviews.append(ReviewsInformation(author: resultDetailReviews.author ?? "",
                                                    avatar_path: resultDetailReviews.authorDetails?.avatarPath,
                                                    content: resultDetailReviews.content ?? ""))
        }
        self.presenter?.setResponseDetailsMovies(with: detailReviews)
    }
    
    func getRecomendations() {
        movieApi.getMovies(OptionMovie.getRecomendations(moviesInfo?.id ?? 0).request){ [weak self] (result: Result< RecomendationsResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let moviesReponse):
                    if moviesReponse.recomendations?.count ?? 0 > 0{
                        self?.setRecomendations(with: moviesReponse.recomendations)
                    }else{
                        self?.presenter?.setError()
                    }
                default:
                    self?.presenter?.setError()
                }
            }
        }
    }
    
    func setRecomendations (with resultRecomendations: [Recomendations]?){
        var recomendationData              : [RecomendationsData] = []
        for infoRecomendations in resultRecomendations ?? [Recomendations](){
            recomendationData.append(RecomendationsModel(title: infoRecomendations.title ?? "",
                                                      posterPath: infoRecomendations.posterPath,
                                                      overview: infoRecomendations.overview ?? ""))
        }
        self.presenter?.setResponseRecomendations(with: recomendationData)
    }
    
}
