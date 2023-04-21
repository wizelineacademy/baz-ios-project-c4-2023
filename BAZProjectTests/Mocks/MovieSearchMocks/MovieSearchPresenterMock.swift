//
//  MovieSearchPresenterMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import Foundation
@testable import BAZProject

enum MovieSearchPresenterMockCalls {
    case searchMovie
    case reloadInfo
    case presentMovieDetailView
    case didSelectRowAt
    case onReceivedSearchedList
    case onReceivedMovie
    case onReceivedError
}

final class MovieSearchPresenterMock: MovieSearchPresenterProtocol, MovieSearchInteractorOutputProtocol {
    
    var view: BAZProject.MovieSearchViewControllerProtocol?
    var router: BAZProject.MovieSearchRouterProtocol?
    var interactor: BAZProject.MovieSearchInteractorInputProtocol?
    
    var movieModel: [BAZProject.Movie] = []
    var calls: [MovieSearchPresenterMockCalls] = []
    
    func searchMovie(withQuery query: String) {
        calls.append(.searchMovie)
    }
    
    func reloadInfo() {
        calls.append(.reloadInfo)
    }
    
    func presentMovieDetailView() {
        calls.append(.presentMovieDetailView)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        calls.append(.didSelectRowAt)
    }
    
    func onReceivedSearchedList(with movieList: BAZProject.MoviesResult) {
        calls.append(.onReceivedSearchedList)
    }
    
    func onReceivedMovie(with movie: BAZProject.Movie) {
        calls.append(.onReceivedMovie)
    }
    
    func onReceived(with error: Error) {
        calls.append(.onReceivedError)
    }
}
