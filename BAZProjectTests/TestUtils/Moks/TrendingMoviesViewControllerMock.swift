//
//  TrendingMoviesViewControllerMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum TrendigMoviesViewControllerMockCalls{
    case loadData
}

final class TrendigMoviesViewControllerMock: UIViewController, TrendingMoviesViewProtocol{
    
    var presenter: BAZProject.TrendingMoviesPresenterProtocol?
    var restoredState: BAZProject.RestorableStateProtocol = BAZProject.SearchControllerRestorableState()
    var calls: [TrendigMoviesViewControllerMockCalls] = []
    
    func loadData(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.loadData)
    }
    
    
}
