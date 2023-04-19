//
//  SearchMoviesProtocols.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import UIKit

//MARK: View
protocol SearchMoviesViewInputProtocol: AnyObject{
    
    var presenter : SearchMoviesViewOutputProtocol? { get }
    
    func showResultMovies(with moviesData: [MovieData])
}

// MARK: - Presenter
protocol SearchMoviesViewOutputProtocol {
    
    var view        : SearchMoviesViewInputProtocol? { get }
    var interactor  : SearchMoviesInteractorInputProtocol { get }
    var router      : SearchMoviesRouterProtocol { get }
    
    func searchMoview(with word: String)
}

protocol SearchMoviesInteractorOutputProtocol: AnyObject {
    func setResponseMovies(with moviesData: [MovieData])
    func setError()
}

// MARK: - Router
protocol SearchMoviesRouterProtocol {
    
    var view        : SearchMoviesView? { get }
    
    func presentAlert(_ alert : UIAlertController)
    
}

// MARK: - Interactor
protocol SearchMoviesInteractorInputProtocol {
    
    var presenter   : SearchMoviesInteractorOutputProtocol? { get }
    
    func consultServiceSearch(with word: String)
    
}
