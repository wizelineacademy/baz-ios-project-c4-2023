//
//  TrendingBarProtocols.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import UIKit

// MARK: - VIPER protocols

// Presenter > Router
protocol TrendingBarRouterProtocol {
    /**
     Function that create a UIViewController.
     
     - Returns:
         - UIViewController: view 
     */
    func createTrendingModule() -> UIViewController
    
    /**
     Function that perform a pushed method.
     
     - Parameters:
         - view: UIViewController that is going to push to nextView.
         - nextView: new principal user UIViewController
     */
    func presentMovieSearchViewController(from view: TrendingBarViewControllerProtocol?)
    func presentDetailViewController(from view: TrendingBarViewControllerProtocol?, withMovie movie: [MovieDetailModel])
}

// View > Presenter
protocol TrendingBarViewControllerProtocol: AnyObject {
    var presenter: TrendingBarPresenterProtocol? { get set }
    
    /**
     Function that reload the view.
     */
    func reloadTendingInfo()
    func fillTrendingList()
    
    /**
     Function that reload the view with an specific error.
     
     - Parameters:
         - error: Service module error.
     */
    func reload(with error: Error)
    func showAlert(withTitle title: String, withMessage message: String, withActions actions: [(String, UIAlertAction.Style)])
}

// Presenter > View
protocol TrendingBarPresenterProtocol: AnyObject {
    var view: TrendingBarViewControllerProtocol? { get set }
    var router: TrendingBarRouterProtocol? { get set }
    var trendingModel: [Movie] { get set }
    
    func willFetchMovieList()
    func reloadInfo()
    func prepareActionSheet()
    func search(byFilter filter: Int)
    func presentSearchView()
    func didSelectRowAt(_ indexPath: IndexPath)
}

extension TrendingBarPresenterProtocol {
    func linkDependencies(view: TrendingBarViewControllerProtocol, router: TrendingBarRouterProtocol, interactor: TrendingBarInteractorInputProtocol) {
        self.view = view
        (self as? TrendingBarInteractorOutputProtocol)?.interactor = interactor
        self.router = router
    }
}

// Presenter > Interactor
protocol TrendingBarInteractorInputProtocol: AnyObject {
    var presenter: TrendingBarInteractorOutputProtocol? { get set }
    var remoteData: TrendingBarRemoteDataInputProtocol? { get set }
    
    func fetchMovieList(_ endPoint: EndPointProtocol)
    func fetchImageFrom(_ movie: MovieResult)
    func linkDependencies(remoteData: TrendingBarRemoteDataInputProtocol, presenter: TrendingBarInteractorOutputProtocol)
}

extension TrendingBarInteractorInputProtocol {
    func linkDependencies(remoteData: TrendingBarRemoteDataInputProtocol, presenter: TrendingBarInteractorOutputProtocol) {
        self.presenter = presenter
        self.remoteData = remoteData
    }
}

// Interactor > Presenter
protocol TrendingBarInteractorOutputProtocol: AnyObject {
    var interactor: TrendingBarInteractorInputProtocol? { get set }
    
    func onReceivedTrendingList(with trendingList: MoviesResult)
    func onReceivedMovie(with movie: Movie)
    func onReceived(with error: Error)
}

// Interactor > RemoteData
protocol TrendingBarRemoteDataInputProtocol: AnyObject {
    var interactor: TrendingBarRemoteDataOutputProtocol? { get set }
    
    func requestMovieList(byEndPoint endPoint: EndPointProtocol)
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void)
}

// RemoteData > Interactor
protocol TrendingBarRemoteDataOutputProtocol: AnyObject {
    func handleTrendingFetchedList(_ trendingList: MoviesResult)
    func handleService(error: Error)
}
