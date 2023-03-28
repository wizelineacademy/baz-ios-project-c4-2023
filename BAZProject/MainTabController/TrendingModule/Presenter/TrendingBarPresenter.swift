//
//  TrendingBarPresenter.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import UIKit

final class TrendingBarPresenter {
    weak var view: TrendingBarViewControllerProtocol?
    var router: TrendingBarRouterProtocol?
    var interactor: TrendingBarInteractorInputProtocol?
    
    var trendingModel: [Movie] = []
}

extension TrendingBarPresenter: TrendingBarPresenterProtocol {
    func reloadInfo() {
        view?.reloadTendingInfo()
    }
    
    func willFetchMovieList() {
        interactor?.fetchMovieList(Endpoint.trending)
        view?.showLoadingView()
    }
    
    func prepareActionSheet() {
        var actions: [(String, UIAlertAction.Style)] = []
        actions.append(("Trending", UIAlertAction.Style.default))
        actions.append(("Now Playing", UIAlertAction.Style.default))
        actions.append(("Popular", UIAlertAction.Style.default))
        actions.append(("Top Rated", UIAlertAction.Style.default))
        actions.append(("Upcoming", UIAlertAction.Style.default))
        actions.append(("Cancel", UIAlertAction.Style.cancel))
        view?.showAlert(withTitle: "Filter By", withMessage: "Select the filter you want the most", withActions: actions)
    }
    
    func search(byFilter filter: Int) {
        var endPoint = Endpoint.trending
        guard let action = AlertSheetActions(rawValue: filter) else {
            endPoint = .trending
            return
        }
        
        switch action {
        case .trending:
            endPoint = .trending
        case .nowPlaying:
            endPoint = .nowPlaying
        case .popular:
            endPoint = .popular
        case .topRated:
            endPoint = .topRated
        case .upcoming:
            endPoint = .upcoming
        }
        
        interactor?.fetchMovieList(endPoint)
        view?.showLoadingView()
    }
}

extension TrendingBarPresenter: TrendingBarInteractorOutputProtocol {
    func onReceivedTrendingList(with trendingModel: [Movie]) {
        self.trendingModel.removeAll()
        self.trendingModel = trendingModel
        view?.dismissLoadingView()
        view?.fillTrendingList()
    }
    
    func onReceived(with error: Error) {
        view?.reload(with: error)
    }
}
