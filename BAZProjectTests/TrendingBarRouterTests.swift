//
//  TrendingBarRouterTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 30/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingBarRouterTests: XCTestCase {
    
    private var sut: BAZProject.TrendingBarRouterProtocol!

    override func setUp() {
        super.setUp()
        
        sut = BAZProject.TrendingBarRouter()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_presentMovieDetailViewController_pushedToMovieDetailController() {
        let initialController = TrendingBarViewControllerMock()
        let navigationControllerSpy = NavigationControllerSpy(rootViewController: initialController)
        
        sut.presentMovieDetailController(from: initialController)
        
        XCTAssert(navigationControllerSpy.pushedViewController is BAZProject.MovieDetailViewController)
    }
    
    func test_presentSearchViewController_pushedToMovieSearchViewController() {
        let initialController = TrendingBarViewControllerMock()
        let navigationControllerSpy = NavigationControllerSpy(rootViewController: initialController)
        
        sut.presentSearchViewController(from: initialController)
        
        XCTAssert(navigationControllerSpy.pushedViewController is BAZProject.SearchMoviesViewController)
    }
}
