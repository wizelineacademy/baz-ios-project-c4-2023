//
//  MovieSearchPresenterTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import XCTest
@testable import BAZProject

final class MovieSearchPresenterTests: XCTestCase {
    private var sut: BAZProject.MovieSearchPresenter!
    private var searchViewMock: MovieSearchViewControllerMock!
    private var routerMock: MovieSearchRouterMock!
    private var interactorMock: MovieSearchInteractorMock!

    override func setUp() {
        super.setUp()
        sut = MovieSearchPresenter()
        searchViewMock = MovieSearchViewControllerMock()
        routerMock = MovieSearchRouterMock()
        searchViewMock = MovieSearchViewControllerMock()
        interactorMock = MovieSearchInteractorMock()
        sut.router = routerMock
        sut.interactor = interactorMock
        sut.view = searchViewMock
    }
    
    override func tearDown() {
        sut = nil
        searchViewMock = nil
        routerMock = nil
        interactorMock = nil
        super.tearDown()
    }
    
    func test_didSelectRow_callsRouter() {
        let indexPath = IndexPath(row: 0, section: 0)
        sut.movieModel.append(Movie(id: 1, title: "", posterPath: Data(), summary: "", backdropPath: "", backdropPathData: nil))

        sut.didSelectRowAt(indexPath)

        XCTAssertEqual(routerMock.calls, [.presentDetailViewController])
    }
    
    func test_reloadInfo_callsViewReloadMovieInfo() {
        sut.reloadInfo()
        
        XCTAssertEqual(searchViewMock.calls, [.reloadMovieInfo])
    }
    
    func test_searchMovie_callsFetchSearchMovieResults() {
        sut.searchMovie(withQuery: "")
        
        XCTAssertEqual(interactorMock.calls, [.fetchSearchMovieResults])
    }
    
    func test_onReceivedSearchedList_callsFetchImage() {
        let moviesResult = MovieFakes().movieResult
        
        sut.onReceivedSearchedList(with: moviesResult)
        
        XCTAssertEqual(interactorMock.calls, [.fetchImageFrom])
    }
    
    func test_onReceivedMovie_callsFillsMovieList() {
        let movie = Movie(id: 2, title: "", posterPath: Data(), summary: "", backdropPath: "", backdropPathData: nil)
        
        sut.onReceivedMovie(with: movie)
        
        XCTAssertEqual(searchViewMock.calls, [.fillMovieList])
    }
    
    func test_onReceivedWithError_callsViewReloadWithError() {
        let error = ServiceError.internalServer
        
        sut.onReceived(with: error)
        
        XCTAssertEqual(searchViewMock.calls, [.reloadWithError])
    }
}
