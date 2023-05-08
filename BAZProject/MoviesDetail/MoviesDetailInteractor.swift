//
//  MoviesDetailInteractor.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import Foundation
enum OptionDetail {
    case Recomendations
    case Similars
    case Reviews
}
final class MoviesDetailInteractor {
    
    // MARK: Properties
    weak var presenter  : MoviesDetailInteractorOutputProtocol?
    
    var movieApi        : Service
    var moviesInfo      : MovieData?
    var bIsFavorite     : Bool?
    
    init(movieApi: Service, moviesInfo: MovieData?) {
        self.movieApi   = movieApi
        self.moviesInfo = moviesInfo
    }
    
}
// MARK: Extension
extension MoviesDetailInteractor: MoviesDetailInteractorInputProtocol{
    
    // MARK: - Functions getInfo
    /// this  Generic function calls service
    /// - Parameter typeDetail: Type of request to make
    func getInfo(detail typeDetail: OptionDetail?) {
        switch typeDetail{
        case .Similars: movieApi.getMovies((OptionMovie.getSimilars(moviesInfo?.id ?? 0).request), callback: handlerResponseSimilarsResult(result:))
        case .Recomendations: movieApi.getMovies((OptionMovie.getRecomendations(moviesInfo?.id ?? 0).request), callback: handlerResponseDetailResult(result:))
        case .Reviews: movieApi.getMovies((OptionMovie.getReviews(moviesInfo?.id ?? 0).request), callback: handlerResponse(result:))
        default: return
        }
    }
    
    func handlerResponse(result: Result <MovieDetailResult, Error>){
        DispatchQueue.main.async {
            switch result {
            case .success(let moviesReponse):
                if moviesReponse.movies?.count ?? 0 > 0{
                    self.setReviews(with: moviesReponse.movies)
                }else{
                    self.presenter?.setError()
                }
            default:
                self.presenter?.setError()
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
    
    func handlerResponseDetailResult(result: Result <RecomendationsResult, Error>){
        DispatchQueue.main.async {
            switch result {
            case .success(let moviesReponse):
                if moviesReponse.recomendations?.count ?? 0 > 0{
                    self.setInfoDetail(with: moviesReponse.recomendations,
                                            typeDetail: .Recomendations)
                }else{
                    self.presenter?.setError()
                }
            default:
                self.presenter?.setError()
            }
        }
    }
    
    func handlerResponseSimilarsResult(result: Result <MovieSimilars, Error>){
        DispatchQueue.main.async {
            switch result {
            case .success(let moviesReponse):
                if moviesReponse.similars?.count ?? 0 > 0{
                    self.setInfoDetail(with: moviesReponse.similars,
                                            typeDetail: .Similars)
                }else{
                    self.presenter?.setError()
                }
            default:
                self.presenter?.setError()
            }
        }
    }
    
    func setInfoDetail(with resultRecomendations: [Movie]?, typeDetail optionDetail: OptionDetail?){
        var recomendationData              : [InfoDetailData] = []
        for infoRecomendations in resultRecomendations ?? [Movie](){
            recomendationData.append(InfoDetailModel(title: infoRecomendations.title ?? "",
                                                      posterPath: infoRecomendations.posterPath,
                                                      overview: infoRecomendations.overview ?? ""))
        }
        self.presenter?.setResponseDetail(with: recomendationData, detail: optionDetail)
    }
    
    ///This function adds the favorite movie to the UserDefaults
    func addFavoriteMovies() {
        bIsFavorite = true
        guard var favoritesMovies = UserDefaultMannager.get(type: [Int].self, forKey: .favoriteMovies) else { return }
        favoritesMovies.append(moviesInfo?.id ?? 0)
        UserDefaultMannager.set(value: favoritesMovies, key: .favoriteMovies)
        presenter?.showBtnFavorites(with: true)
    }
    
    ///This function gets favorite movie from UserDefaults
    func getFavoriteMovies() -> Bool {
        guard let favoritesMovies = UserDefaultMannager.get(type: [Int].self, forKey: .favoriteMovies) else { return false }
        return favoritesMovies.contains(moviesInfo?.id ?? 0)
    }
    
    ///This function removes the favorite movie from UserDefaults
    func removeFavoriteMovies() {
        guard var favoritesMovies = UserDefaultMannager.get(type: [Int].self, forKey: .favoriteMovies) else { return }
        for (index, value) in favoritesMovies.enumerated(){
            if value == moviesInfo?.id ?? 0 {
                bIsFavorite = false
                favoritesMovies.remove(at: index)
            }
        }
        UserDefaultMannager.set(value: favoritesMovies, key: .favoriteMovies)
        presenter?.showBtnFavorites(with: bIsFavorite)
    }
    
}
