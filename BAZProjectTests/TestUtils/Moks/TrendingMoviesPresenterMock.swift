//
//  TrendingMoviesPresenterMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import Foundation
import UIKit
@testable import BAZProject

enum TrendingMoviesPresenterCalls{
    case getMovies
    case setMovies
    case getResultViewController
    case findMovies
    case loadFindMovies
    case cleanStringForSearch
    case sendToDetail
}

final class TrendingMoviesPresenterMock: MoviesPresenterProtocol{

    var calls: [TrendingMoviesPresenterCalls] = []
    var interface: TrendigMoviesViewControllerMock? = TrendigMoviesViewControllerMock(restoredState: SearchControllerRestorableState())
    var interactor: MoviesInteractorProtocol?
    var router: MoviesWireframeProtocol
    var textToSearch: String?
    
    
    init(textToSearch: String? = nil, interface: MoviesViewProtocol? = nil, interactor: MoviesInteractorProtocol? = nil, router: MoviesWireframeProtocol) {
        self.textToSearch = textToSearch
        self.interface = interface as? TrendigMoviesViewControllerMock
        self.interactor = interactor
        self.router = router
        self.interactor = interactor
        self.router = router
    }
    
    func getMovies() {
        calls.append(.getMovies)
    }
    
    func setMovies(result: [BAZProject.ListMovieProtocol]) {
        calls.append(.setMovies)
    }
    
    func findMovies(for string: String?) {
        self.textToSearch = string
        interactor?.findMovies(for: string ?? "")
        calls.append(.findMovies)
    }
    
    func loadFindMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.loadFindMovies)
    }
    
    func cleanStringForSearch(_ string: String?) -> String {
        calls.append(.cleanStringForSearch)
        return string ?? ""
    }
    
    func sendToDetail(movie: BAZProject.Movie) {
        calls.append(.sendToDetail)
    }

}
