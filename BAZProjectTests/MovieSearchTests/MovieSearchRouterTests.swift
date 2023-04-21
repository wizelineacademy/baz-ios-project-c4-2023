//
//  MovieSearchRouterTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import XCTest
@testable import BAZProject

final class MovieSearchRouterTests: XCTestCase {
    private var sut: BAZProject.MovieSearchRouter!

    override func setUp() {
        super.setUp()
        sut = MovieSearchRouter()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_presentMovieDetailViewController_pushedToMovieDetailController() {
        let initialController = SearchMoviesViewController()
        let navigationControllerSpy = NavigationControllerSpy(rootViewController: initialController)
        
        sut.presentDetailViewController(from: initialController)
        
        XCTAssert(navigationControllerSpy.pushedViewController is BAZProject.MovieDetailViewController)
    }
}
