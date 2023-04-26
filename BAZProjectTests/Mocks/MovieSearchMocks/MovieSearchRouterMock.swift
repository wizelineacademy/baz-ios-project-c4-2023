//
//  MovieSearchRouterMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import UIKit
@testable import BAZProject

enum MovieSearchRouterMockCalls {
    case createSearchMovieModule
    case presentDetailViewController
}

final class MovieSearchRouterMock: MovieSearchRouterProtocol {
    var calls: [MovieSearchRouterMockCalls] = []
    
    func createSearchMovieModule() -> UIViewController {
        calls.append(.createSearchMovieModule)
        return UIViewController() as! SearchMoviesViewController
    }
    
    func presentDetailViewController(from view: BAZProject.MovieSearchViewControllerProtocol?) {
        calls.append(.presentDetailViewController)
    }
}
