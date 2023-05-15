//
//  MovieDetailProtocols.swift
//  BAZProject
//
//  Created by 989438 on 27/04/23.
//

import UIKit

// Presenter > Router
protocol MovieDetailRouterProtocol {
    /**
     Function that create a UIViewController.
     
     - Returns:
         - UIViewController: view
     */
    func createMovieDetailModule(withMovie movie: [MovieDetailModel]) -> UIViewController
    
    /**
     Function that perform a pushed method.
     
     - Parameters:
         - view: UIViewController that is going to push to nextView.
         - nextView: new principal user UIViewController
     */
    func presentDetailViewController(from view: MovieDetailViewControllerProtocol?, withMovie movie: [MovieDetailModel])
}

// View > Presenter
protocol MovieDetailViewControllerProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol? { get set }
    var storageObject: StorageProtocol? { get set }
    
    /**
     Function that reload the view.
     */
    func reloadMovieDetailInfo()
    /**
     Function that reload the view with an specific error.
     
     - Parameters:
         - error: Service module error.
     */
    func reload(with error: Error)
}

// Presenter > View
protocol MovieDetailPresenterProtocol: AnyObject {
    var view: MovieDetailViewControllerProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    var movieModel: [MovieDetailModel] { get set }
    
    func searchForActors(in movie: Int)
    func searchForSimilarMovies(of movie: Int)
    func searchForRecommendedMovies(of movie: Int)
    func searchForReviews(for movie: Int)
    func getMovieBanner()
    func didSelectRowAt(_ indexPath: IndexPath, _ items: [Movie])
}

extension MovieDetailPresenterProtocol {
    func linkDependencies(view: MovieDetailViewControllerProtocol, router: MovieDetailRouterProtocol, interactor: MovieDetailInteractorInputProtocol) {
        self.view = view
        (self as? MovieDetailInteractorOutputProtocol)?.interactor = interactor
        self.router = router
    }
}

// Presenter > Interactor
protocol MovieDetailInteractorInputProtocol: AnyObject {
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var remoteData: MovieDetailRemoteDataInputProtocol? { get set }
    
    func fetchForActors(_ endPoint: EndPointProtocol)
    func fetchForSimilarMovies(_ endPoint: EndPointProtocol)
    func fetchForRecommendedMovies(_ endPoint: EndPointProtocol)
    func fetchMovieBanner(_ urlString: String)
    func fetchSimilarImageFrom(_ movies: [MovieResult])
    func fetchRecommendedImageFrom(_ movies: [MovieResult])
    func fetchImageProfile(_ actors: [Actor])
    func fetchUserReviews(_ endPoint: EndPointProtocol)
    func fetchUserAvatar(_ reviews: [Review])
}

extension MovieDetailInteractorInputProtocol {
    func linkDependencies(remoteData: MovieDetailRemoteDataInputProtocol, presenter: MovieDetailInteractorOutputProtocol) {
        self.presenter = presenter
        self.remoteData = remoteData
    }
}

// Interactor > Presenter
protocol MovieDetailInteractorOutputProtocol: AnyObject {
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    
    func onReceivedActors(with actorList: MovieCast)
    func onReceivedActorModel(withActorModel actor: [ActorModel])
    func onReceivedSimilarMovies(with movies: MoviesResult)
    func onReceivedSimilarMoviesModel(with movies: [Movie])
    func onReceivedRecommendedMovies(with movies: MoviesResult)
    func onReceivedRecommendedMoviesModel(with movies: [Movie])
    func onReceivedMovieBanner(with banner: Data)
    func onReceived(with error: Error)
    func onReceivedUserReviews(with reviews: ReviewResponse)
    func onReceivedUserReviewModel(with reviews: [ReviewModel])
}

// Interactor > RemoteData
protocol MovieDetailRemoteDataInputProtocol: AnyObject {
    var interactor: MovieDetailRemoteDataOutputProtocol? { get set }
    
    func requestActors(withEndPoint endPoint: EndPointProtocol)
    func requestSimilarMovies(withEndPoint endPoint: EndPointProtocol)
    func requestRecommendedMovies(withEndPoint endPoint: EndPointProtocol)
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void)
    func requestProfileImageData(actors: [Actor], completion: @escaping ([ActorModel]) -> Void)
    func requestMoviesImageData(movies: [MovieResult], completion: @escaping ([Movie]) -> Void)
    func requestUserImageData(reviews: [Review], completion: @escaping ([ReviewModel]) -> Void)
    func requestUserReviews(withEndPoint endPoint: EndPointProtocol)
}

// RemoteData > Interactor
protocol MovieDetailRemoteDataOutputProtocol: AnyObject {
    func handleActorsFetchedList(_ actorList: MovieCast)
    func handleSimilarMoviesFetchedList(_ movieList: MoviesResult)
    func handleRecommendedMoviesFetchedList(_ movieList: MoviesResult)
    func handleUserReviewsFetchedList(_ reviewList: ReviewResponse)
    func handleService(error: Error)
}

