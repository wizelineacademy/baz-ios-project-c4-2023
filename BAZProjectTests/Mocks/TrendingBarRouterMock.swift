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
    case presentSearchViewController
    case presentMovieDetailController
}

final class TrendingBarRouterMock: TrendingBarRouterProtocol {
    var calls: [TrendingBarRouterMockCalls] = []
    
    func createTrendingModule() -> UIViewController {
        calls.append(.createTrendingModule)
        return UIViewController() as! TrendingViewController
    }
    
    func presentSearchViewController(from view: BAZProject.TrendingBarViewControllerProtocol?) {
        calls.append(.presentSearchViewController)
    }
    
    func presentMovieDetailController(from view: BAZProject.TrendingBarViewControllerProtocol?) {
        calls.append(.presentMovieDetailController)
    }
}
