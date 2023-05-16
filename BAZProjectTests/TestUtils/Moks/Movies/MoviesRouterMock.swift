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
///Clase mock de MoviesRouterMock
///
final class MoviesRouterMock: MoviesWireframeProtocol {

    
    var calls: [MoviesRouterMockCalls] = []
    
    ///metodo que llama getResultViewController del router
    func getResultViewController() -> UIViewController {
        calls.append(.getResultViewController)
        return BAZProject.MoviesViewController()
    }
    
    ///metodo que llama sendToDetail del router
    func sendToDetail(with movie: BAZProject.Movie) {
        calls.append(.sendToDetail)
    }
    

}
