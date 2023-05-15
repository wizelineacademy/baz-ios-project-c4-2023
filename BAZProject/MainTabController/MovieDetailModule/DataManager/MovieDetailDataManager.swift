//
//  MovieDetailDataManager.swift
//  BAZProject
//
//  Created by 989438 on 27/04/23.
//

import Foundation

final class MovieDetailDataManager {
    weak var interactor: MovieDetailRemoteDataOutputProtocol?
    private var service: Service
    var actorArray: [ActorModel] = []
    
    init(service: Service) {
        self.service = service
    }
}

extension MovieDetailDataManager: MovieDetailRemoteDataInputProtocol {
    func requestActors(withEndPoint endPoint: EndPointProtocol) {
        service.get(endPoint) { [weak self] (result: Result<MovieCast, Error>) in
            switch result {
            case .success(let actorList):
                self?.interactor?.handleActorsFetchedList(actorList)
            case .failure(let error):
                self?.interactor?.handleService(error: error)
            }
        }
    }
    
    func requestSimilarMovies(withEndPoint endPoint: EndPointProtocol) {
        service.get(endPoint) { [weak self] (result: Result<MoviesResult, Error>) in
            switch result {
            case .success(let movies):
                self?.interactor?.handleSimilarMoviesFetchedList(movies)
            case .failure(let error):
                self?.interactor?.handleService(error: error)
            }
        }
    }
    
    func requestRecommendedMovies(withEndPoint endPoint: EndPointProtocol) {
        service.get(endPoint) { [weak self] (result: Result<MoviesResult, Error>) in
            switch result {
            case .success(let movies):
                self?.interactor?.handleRecommendedMoviesFetchedList(movies)
            case .failure(let error):
                self?.interactor?.handleService(error: error)
            }
        }
    }
    
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        service.fetchImageData(urlString: urlString, completion: completion)
    }
    
    func requestProfileImageData(actors: [Actor], completion: @escaping ([ActorModel]) -> Void) {
        let myProfileGroup = DispatchGroup()
        for actor in actors {
            myProfileGroup.enter()
            service.fetchImageData(urlString: "\(EndPointConstants.mediaEndPoint)\(actor.profilePath ?? "")") { [weak self] imgData in
                self?.actorArray.append(ActorModel(name: actor.name ?? "", profileImage: imgData))
                myProfileGroup.leave()
            }
        }
        myProfileGroup.notify(queue: .main) {
            completion(self.actorArray)
        }
    }
    
    func requestMoviesImageData(movies: [MovieResult], completion: @escaping ([Movie]) -> Void) {
        var movieArray: [Movie] = []
        let myProfileGroup = DispatchGroup()
        for movie in movies {
            myProfileGroup.enter()
            service.fetchImageData(urlString: "\(EndPointConstants.mediaEndPoint)\(movie.posterPath ?? "")") { imgData in
                guard let img = imgData else { return }
                movieArray.append(Movie(id: movie.id ?? 0, title: movie.title ?? "", posterPath: img, summary: movie.overview ?? "", backdropPath: movie.backdropPath ?? "", backdropPathData: nil))
                myProfileGroup.leave()
            }
        }
        myProfileGroup.notify(queue: .main) {
            completion(movieArray)
        }
    }
    
    func requestUserReviews(withEndPoint endPoint: EndPointProtocol) {
        service.get(endPoint) { [weak self] (result: Result<ReviewResponse, Error>) in
            switch result {
            case .success(let reviews):
                self?.interactor?.handleUserReviewsFetchedList(reviews)
            case .failure(let error):
                self?.interactor?.handleService(error: error)
            }
        }
    }
    
    func requestUserImageData(reviews: [Review], completion: @escaping ([ReviewModel]) -> Void) {
        var userReviews: [ReviewModel] = []
        let myReviewGroup = DispatchGroup()
        for review in reviews {
            myReviewGroup.enter()
            service.fetchImageData(urlString: "\(EndPointConstants.mediaEndPoint)\(review.authorDetails?.avatarPath ?? "")") { imgData in
                guard let img = imgData else { return }
                userReviews.append(ReviewModel(name: review.author ?? "", rating: review.authorDetails?.rating ?? 0, content: review.content ?? "", avatar: img))
                myReviewGroup.leave()
            }
            myReviewGroup.notify(queue: .main) {
                completion(userReviews)
            }
        }
    }
}
