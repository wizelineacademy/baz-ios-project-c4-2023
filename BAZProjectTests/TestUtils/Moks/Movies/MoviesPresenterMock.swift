//
//  TrendingMoviesPresenterMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum MoviesPresenterCalls{
    case getMovies
    case setMovies
    case getResultViewController
    case findMovies
    case loadFindMovies
    case cleanStringForSearch
    case sendToDetail
}

final class MoviesPresenterMock: MoviesPresenterProtocol{

    var calls: [MoviesPresenterCalls] = []
    var interface: MoviesViewControllerMock? = MoviesViewControllerMock(restoredState: SearchControllerRestorableState())
    var interactor: MoviesInteractorProtocol?
    var router: MoviesWireframeProtocol
    var textToSearch: String?
    
    
    ///incializador de  MoviesPresenterMock
    /// - parameters:
    ///    - textToSearch: textToSearch  con que se inicializa MovieDetailPresenterMock
    ///    - interface: view  que contien el MovieDetailPresenterMock
    ///    - interactor:Interactor  que contien el MovieDetailPresenterMock
    ///    - router: router  que contien el MovieDetailPresenterMock
    init(textToSearch: String? = nil, interface: MoviesViewProtocol? = nil, interactor: MoviesInteractorProtocol? = nil, router: MoviesWireframeProtocol) {
        self.textToSearch = textToSearch
        self.interface = interface as? MoviesViewControllerMock
        self.interactor = interactor
        self.router = router
        self.interactor = interactor
        self.router = router
    }
    
    ///metodo que llama getMovies del presenter
    func getMovies() {
        calls.append(.getMovies)
    }
    
    ///metodo que llama setMovies del presenter
    func setMovies(result: [BAZProject.ListMovieProtocol]) {
        calls.append(.setMovies)
    }
    
    ///metodo que llama findMovies del presenter
    func findMovies(for string: String?) {
        self.textToSearch = string
        interactor?.findMovies(for: string ?? "")
        calls.append(.findMovies)
    }
    
    ///metodo que llama loadFindMovies del presenter
    func loadFindMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.loadFindMovies)
    }
    
    ///metodo que llama cleanStringForSearch del presenter
    func cleanStringForSearch(_ string: String?) -> String {
        calls.append(.cleanStringForSearch)
        return string ?? ""
    }
    
    ///metodo que llama v del presenter
    func sendToDetail(movie: BAZProject.Movie) {
        calls.append(.sendToDetail)
    }

}
