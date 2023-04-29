//
//  TrendingBarRouterMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 30/03/23.
//

@testable import BAZProject
import UIKit

enum TrendingBarRouterMockCalls {
    case createTrendingModule
    case presentDetailViewController
    case presentMovieSearchViewController
}

final class TrendingBarRouterMock: TrendingBarRouterProtocol {
    var calls: [TrendingBarRouterMockCalls] = []
    
    func createTrendingModule() -> UIViewController {
        calls.append(.createTrendingModule)
        return UIViewController() as! TrendingViewController
    }
    
    func presentMovieSearchViewController(from view: BAZProject.TrendingBarViewControllerProtocol?) {
        calls.append(.presentMovieSearchViewController)
    }
    
    func presentDetailViewController(from view: BAZProject.TrendingBarViewControllerProtocol?, withMovie movie: [BAZProject.MovieDetailModel]) {
        calls.append(.presentDetailViewController)
    }
}
