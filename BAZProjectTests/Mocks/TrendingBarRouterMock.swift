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
    case presentNextViewController
}

final class TrendingBarRouterMock: TrendingBarRouterProtocol {
    var calls: [TrendingBarRouterMockCalls] = []
    
    func createTrendingModule() -> UIViewController {
        calls.append(.createTrendingModule)
        return UIViewController() as! TrendingViewController
    }
    
    func presentNextViewController(from view: BAZProject.TrendingBarViewControllerProtocol?, to nextView: UIViewController) {
        calls.append(.presentNextViewController)
    }
}
