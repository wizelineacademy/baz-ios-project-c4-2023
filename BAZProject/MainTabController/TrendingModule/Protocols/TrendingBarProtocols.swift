//
//  TrendingBarProtocols.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import UIKit

// MARK: - VIPER protocols

// Presenter > Router
protocol TrendingBarRouterProtocol: AnyObject {
    func createTrendingModule() -> UIViewController
}

// View > Presenter
protocol TrendingBarViewControllerProtocol: AnyObject {
    var presenter: TrendingBarPresenterProtocol? { get set }
//    var trendingList: [TrendingCellModel] { get set }
    
    func reloadTendingInfo()
    func fillTrendingList()
    func reload(with error: Error)
    func showAlert(withTitle title: String, withMessage message: String, withActions actions: [(String, UIAlertAction.Style)])
    func showLoadingView()
    func dismissLoadingView()
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
    
    func fetchMovieList(_ endPoint: Endpoint)
    
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
    
    func onReceivedTrendingList(with trendingModel: [Movie])
    func onReceived(with error: Error)
}

// Interactor > RemoteData
protocol TrendingBarRemoteDataInputProtocol: AnyObject {
    var interactor: TrendingBarRemoteDataOutputProtocol? { get set }
    
    func requestMovieList(byEndPoint endPoint: Endpoint)
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void)
}

// RemoteData > Interactor
protocol TrendingBarRemoteDataOutputProtocol: AnyObject {
    func handleTrendingFetchedList(_ trendingList: TrendingMoviesResult)
    func handleService(error: Error)
}
