//
//  TrendingMoviesRouterMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum TrendingMoviesRouterMockCalls{
    case getResultViewController
}

final class TrendingMoviesRouterMock: TrendingMoviesWireframeProtocol {
    
    var calls: [TrendingMoviesRouterMockCalls] = []
    
    func getResultViewController() -> UIViewController {
        calls.append(.getResultViewController)
        return BAZProject.TrendingMoviesViewController()
    }

}
