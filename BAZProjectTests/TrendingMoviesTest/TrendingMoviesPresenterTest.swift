//
//  TrendingMoviesPresenterTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest

@testable import BAZProject

final class TrendingMoviesPresenterTest: XCTestCase{
    
    private var sut: BAZProject.TrendingMoviesPresenter!
    private var viewControllerMock: TrendigMoviesViewControllerMock!
    private var interactorMock: TrendingMoviesInteractorMock!
    private var routerMock: TrendingMoviesRouterMock!
    
    override func setUp() {
        super.setUp()
        viewControllerMock = TrendigMoviesViewControllerMock()
        interactorMock = TrendingMoviesInteractorMock(movieAPI: FakeMovieApi(resultType: .sucess))
        routerMock = TrendingMoviesRouterMock()
        
        sut = BAZProject.TrendingMoviesPresenter(interface: viewControllerMock,
                                                 interactor: interactorMock,
                                                 router: routerMock)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewControllerMock = nil
        interactorMock = nil
        routerMock = nil
    }
    
    func test_getMovies_callsInteractorGetMovies() {
        sut.getMovies()
        XCTAssertEqual(interactorMock.calls, [.getMovies])
    }
    
    func test_setMovies_callsViewToAddData(){
        let fakeMovies: [ListMovieProtocol] = []
        sut.setMovies(result: fakeMovies)
        XCTAssertEqual(viewControllerMock.calls, [.loadData])
    }
    
    func test_getResultViewController_returnsResultViewController(){
        let fakeViewControler = sut.getResultViewController()
        XCTAssert(fakeViewControler is UITableViewController)
    }
    
//    func test_getRemotImage_callsInteracrtorGetImage() {
//        var completion = ((UIImage?) -> ()).self
//        sut.getRemotImage(from: "", completion: completion)
//    }
    
//    func findMovies() {
//        sut.findMovies(for: <#T##String#>, completion: <#T##([ListMovieProtocol]) -> ()#>)
//        XCTAssertEqual(interactorMock.calls, [.getMovies])
//    }
}

