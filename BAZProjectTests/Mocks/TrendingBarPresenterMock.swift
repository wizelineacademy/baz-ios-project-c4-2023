//
//  TrendingBarPresenterMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 30/03/23.
//

import Foundation
@testable import BAZProject

enum TrendingBarPresenterMockCalls {
    case willFetchMovieList
    case reloadInfo
    case prepareActionSheet
    case searchByFilter
    case presentSearchView
    case didSelectRowAt
    case onReceivedTrendingList
    case onReceivedMovie
    case onReceivedWithError
}

final class TrendingBarPresenterMock: BAZProject.TrendingBarPresenterProtocol, TrendingBarInteractorOutputProtocol {
    var interactor: BAZProject.TrendingBarInteractorInputProtocol?
    
    var view: BAZProject.TrendingBarViewControllerProtocol?
    
    var router: BAZProject.TrendingBarRouterProtocol?
    
    var trendingModel: [BAZProject.Movie] = []
    
    var calls: [TrendingBarPresenterMockCalls] = []
    
    func willFetchMovieList() {
        calls.append(.willFetchMovieList)
    }
    
    func reloadInfo() {
        calls.append(.reloadInfo)
    }
    
    func prepareActionSheet() {
        calls.append(.prepareActionSheet)
    }
    
    func search(byFilter filter: Int) {
        calls.append(.searchByFilter)
    }
    
    func presentSearchView() {
        calls.append(.presentSearchView)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        calls.append(.didSelectRowAt)
    }
    
    func onReceivedTrendingList(with trendingList: BAZProject.TrendingMoviesResult) {
        calls.append(.onReceivedTrendingList)
    }
    
    func onReceivedMovie(with movie: BAZProject.Movie) {
        calls.append(.onReceivedMovie)
    }
    
    func onReceived(with error: Error) {
        calls.append(.onReceivedWithError)
    }
}
