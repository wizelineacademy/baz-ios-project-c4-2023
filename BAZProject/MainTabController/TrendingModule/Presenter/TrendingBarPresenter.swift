//
//  TrendingBarPresenter.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

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
    
    func willFetchTrendingMovies() {
        interactor?.fetchTrendingList(MainConstants.trendingEndPoint)
    }
}

extension TrendingBarPresenter: TrendingBarInteractorOutputProtocol {
    func onReceivedTrendingList(with trendingModel: [Movie]) {
        self.trendingModel = trendingModel
        view?.fillTrendingList()
    }
    
    func onReceived(with error: Error) {
        view?.reload(with: error)
    }
}
