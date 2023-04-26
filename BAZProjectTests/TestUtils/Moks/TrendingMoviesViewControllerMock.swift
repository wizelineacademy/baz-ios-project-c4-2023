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
    case loadSearchData
}

final class TrendigMoviesViewControllerMock: UIViewController, TrendingMoviesViewProtocol{

    var presenter: BAZProject.TrendingMoviesPresenterProtocol?
    var resultsTableController: BAZProject.ResultsTableController?
    var restoredState: BAZProject.RestorableStateProtocol = BAZProject.SearchControllerRestorableState()
    var calls: [TrendigMoviesViewControllerMockCalls]
    var movies: [BAZProject.ListMovieProtocol]
    var searchResultMovies: [BAZProject.ListMovieProtocol]
    
    
    init(presenter: BAZProject.TrendingMoviesPresenterProtocol? = nil,
         resultsTableController: BAZProject.ResultsTableController? = nil,
         restoredState: BAZProject.RestorableStateProtocol,
         movies: [BAZProject.ListMovieProtocol] = [],
         searchResultMovies: [BAZProject.ListMovieProtocol] = []) {
        
        self.presenter = presenter
        self.resultsTableController = resultsTableController
        self.restoredState = restoredState
        self.calls = []
        self.movies = movies
        self.searchResultMovies = searchResultMovies
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadData(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.loadData)
    }
    
    func loadSearchData(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.loadSearchData)
    }
    
    
}
