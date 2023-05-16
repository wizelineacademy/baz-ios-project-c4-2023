//
//  TrendingMoviesViewControllerMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum MoviesViewControllerMockCalls{
    case loadData
    case loadSearchData
}

final class MoviesViewControllerMock: UIViewController, MoviesViewProtocol{
    var type: (BAZProject.ApiPathProtocol & BAZProject.ViewPropertiesProtocol)?
    var presenter: BAZProject.MoviesPresenterProtocol?
    var resultsTableController: BAZProject.ResultsTableController?
    var restoredState: BAZProject.RestorableStateProtocol = BAZProject.SearchControllerRestorableState()
    var calls: [MoviesViewControllerMockCalls]
    var movies: [BAZProject.ListMovieProtocol]
    var searchResultMovies: [BAZProject.ListMovieProtocol]
    
    
    
    ///incializador de  MoviesViewControllerMock
    /// - parameters:
    ///    - presenter: presneter  con que se inicializa MoviesViewControllerMock
    ///    - resultsTableController: resultsTableController  que contien el MoviesViewControllerMock
    ///    - restoredState:restoredState  que contien el MoviesViewControllerMock
    ///    - movies: movies  que contien el MoviesViewControllerMock
    ///    - searchResultMovies: searchResultMovies  que contien el MoviesViewControllerMock
    init(presenter: BAZProject.MoviesPresenterProtocol? = nil,
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

    ///metodo que llama loadData del view
    func loadData(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.loadData)
    }
    
    ///metodo que llama loadSearchData del view
    func loadSearchData(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.loadSearchData)
    }
    
    
}
