//
//  MovieDetailViewControllerMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import UIKit
@testable import BAZProject

enum MovieDetailViewControllerMockCalls {
    case reloadMovieDetailInfo
    case reloadWithError
}

final class MovieDetailViewControllerMock: UIViewController, BAZProject.MovieDetailViewControllerProtocol {
    var presenter: BAZProject.MovieDetailPresenterProtocol?
    var calls: [MovieDetailViewControllerMockCalls] = []
    
    func reloadMovieDetailInfo() {
        calls.append(.reloadMovieDetailInfo)
    }
    
    func reload(with error: Error) {
        calls.append(.reloadWithError)
    }
}
