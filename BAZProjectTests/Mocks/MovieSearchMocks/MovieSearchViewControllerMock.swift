//
//  MovieSearchViewControllerMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import UIKit
@testable import BAZProject

enum MovieSearchViewControllerMockCalls {
    case reloadMovieInfo
    case fillMovieList
    case reloadWithError
}

final class MovieSearchViewControllerMock: UIViewController, MovieSearchViewControllerProtocol {
    
    var presenter: BAZProject.MovieSearchPresenterProtocol?
    var calls: [MovieSearchViewControllerMockCalls] = []
    
    func reloadMovieInfo() {
        calls.append(.reloadMovieInfo)
    }
    
    func fillMovieList() {
        calls.append(.fillMovieList)
    }
    
    func reload(with error: Error) {
        calls.append(.reloadWithError)
    }
}
