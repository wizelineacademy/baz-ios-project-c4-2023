//
//  MovieDetailRouterMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import UIKit
@testable import BAZProject

enum MovieDetailRouterMockCalls {
    case createMovieDetailModule
    case presentDetailViewController
}

final class MovieDetailRouterMock: BAZProject.MovieDetailRouterProtocol {
    var calls: [MovieDetailRouterMockCalls] = []
    
    func createMovieDetailModule(withMovie movie: [BAZProject.MovieDetailModel]) -> UIViewController {
        calls.append(.createMovieDetailModule)
        return UIViewController() as! MovieDetailViewController
    }
    
    func presentDetailViewController(from view: BAZProject.MovieDetailViewControllerProtocol?) {
        calls.append(.presentDetailViewController)
    }
}
