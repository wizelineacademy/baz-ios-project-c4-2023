//
//  TrendingMoviesPresenterTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest

@testable import BAZProject

final class TrendingMoviesPresenterTest: XCTestCase{
    
    private var sut: MoviesPresenterMock!
    private var viewControllerMock: MoviesViewControllerMock!
    private var interactorMock: MoviesInteractorMock!
    private var routerMock: MoviesRouterMock!
    
    override func setUp() {
        super.setUp()
        viewControllerMock = MoviesViewControllerMock(restoredState: SearchControllerRestorableState())
        interactorMock = MoviesInteractorMock(movieAPI: FakeMovieApi(resultType: .sucess))
        routerMock = MoviesRouterMock()
        
        sut = MoviesPresenterMock(textToSearch: "textToSearch",
                                          interface: viewControllerMock,
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
        XCTAssertEqual(sut.calls, [.getMovies])
    }
    
    func test_setMovies_callsViewToAddData(){
        let fakeMovies: [ListMovieProtocol] = []
        sut.setMovies(result: fakeMovies)
        XCTAssertEqual(sut.calls, [.setMovies])
    }
    
    func test_findMovies() {
        sut.findMovies(for: "textToSearch")
        XCTAssertEqual(sut.calls, [.findMovies])
    }
    
    func test_cleanStringForSearch_returnCleanString(){
        let cleantext = sut.cleanStringForSearch("textToSearch")
        let count = cleantext.count
        XCTAssert(count > 3)
        
    }
    
//    func test_getRemotImage_callsInteracrtorGetImage() {
//        var completion = ((UIImage?) -> ()).self
//        sut.getRemotImage(from: "", completion: completion)
//    }
    

}

