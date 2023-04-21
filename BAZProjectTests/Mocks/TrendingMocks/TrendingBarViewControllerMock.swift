//
//  TrendingBarViewControllerMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 30/03/23.
//

import UIKit
@testable import BAZProject

enum TrendingBarViewControllerMockCalls {
    case reloadTendingInfo
    case fillTrendingList
    case reloadWithError
    case showAlert
}

final class TrendingBarViewControllerMock: UIViewController, TrendingBarViewControllerProtocol {
    var presenter: BAZProject.TrendingBarPresenterProtocol?
    var calls: [TrendingBarViewControllerMockCalls] = []
    
    func reloadTendingInfo() {
        calls.append(.reloadTendingInfo)
    }
    
    func fillTrendingList() {
        calls.append(.fillTrendingList)
    }
    
    func reload(with error: Error) {
        calls.append(.reloadWithError)
    }
    
    func showAlert(withTitle title: String, withMessage message: String, withActions actions: [(String, UIAlertAction.Style)]) {
        calls.append(.showAlert)
    }
}
