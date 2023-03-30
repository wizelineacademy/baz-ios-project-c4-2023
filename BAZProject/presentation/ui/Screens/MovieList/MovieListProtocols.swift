//
//  MovieListProtocols.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation
import UIKit

protocol MovieListsViewProtocol: AnyObject {
    var presenter: MovieListsPresenterProtocol? { get set }
    func showMovies(_ movies: [Movie])
}

protocol MovieListsInteractorProtocol: AnyObject {
    var presenter: MovieListsPresenterProtocol? { get set }
    func getMovies()
}

protocol MovieListsPresenterProtocol: AnyObject {
    var view: MovieListsViewProtocol? { get set }
    func loadMovies()
    func successFetchMovies(_ movies: [Movie])
}

protocol MovieListsRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}
