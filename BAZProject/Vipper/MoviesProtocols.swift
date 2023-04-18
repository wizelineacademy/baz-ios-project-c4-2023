//
//  MoviesProtocols.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import UIKit

//MARK: View
protocol MoviesViewInputProtocol: AnyObject{
    
    var presenter : MoviesViewOutputProtocol? { get }
    
    func showResultMovies(with moviesData: [MovieData])
}

// MARK: - Presenter
protocol MoviesViewOutputProtocol {
    
    var view        : MoviesViewInputProtocol? { get }
    var interactor  : MoviesInteractorInputProtocol { get }
    var router      : MoviesRouterProtocol { get }
    
    func searchMoview(with word: String)
}

protocol MoviesInteractorOutputProtocol: AnyObject {
    func setResponseMovies(with moviesData: [MovieData])
    func setError()
}

// MARK: - Router
protocol MoviesRouterProtocol {
    
    var view        : MoviesView? { get }
    
    func presentAlert(_ alert : UIAlertController, from view: MoviesViewInputProtocol)
    
}

// MARK: - Interactor
protocol MoviesInteractorInputProtocol {
    
    var presenter   : MoviesInteractorOutputProtocol? { get }
    
    func consultServiceSearch(with word: String)
    
}
