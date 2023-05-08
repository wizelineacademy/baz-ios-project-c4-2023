//
//  TrendingMoviesRouterMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum MoviesRouterMockCalls{
    case getResultViewController
    case sendToDetail
}

final class MoviesRouterMock: MoviesWireframeProtocol {

    
    var calls: [MoviesRouterMockCalls] = []
    
    func getResultViewController() -> UIViewController {
        calls.append(.getResultViewController)
        return BAZProject.MoviesViewController()
    }
    func sendToDetail(with movie: BAZProject.Movie) {
        calls.append(.sendToDetail)
    }
    

}
