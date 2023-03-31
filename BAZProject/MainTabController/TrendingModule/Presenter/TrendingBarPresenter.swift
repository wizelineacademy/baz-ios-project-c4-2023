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
        self.trendingModel.removeAll()
        interactor?.fetchMovieList(Endpoint.trending)
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
        self.trendingModel.removeAll()
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
    }
    
    func presentSearchView() {
        let searchViewController = SearchMoviesViewController()
        router?.presentNextViewController(from: view, to: searchViewController)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let detailViewController = MovieDetailViewController()
        router?.presentNextViewController(from: view, to: detailViewController)
    }
}

extension TrendingBarPresenter: TrendingBarInteractorOutputProtocol {
    func onReceivedTrendingList(with trendingList: TrendingMoviesResult) {
        guard let movieList = trendingList.results else { return }
        for movie in movieList {
            interactor?.fetchImageFrom(movie)
        }
    }
    
    func onReceivedMovie(with movie: Movie) {
        self.trendingModel.append(movie)
        view?.fillTrendingList()
    }
    
    func onReceived(with error: Error) {
        view?.reload(with: error)
    }
}
