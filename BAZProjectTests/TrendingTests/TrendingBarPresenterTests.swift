//
//  TrendingBarPresenterTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 30/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingBarPresenterTests: XCTestCase {
    private var sut: BAZProject.TrendingBarPresenter!
    private var trendingViewMock: TrendingBarViewControllerMock!
    private var routerMock: TrendingBarRouterMock!
    private var interactorMock: TrendingBarInteractorMock!

    override func setUp() {
        super.setUp()
        sut = BAZProject.TrendingBarPresenter()
        routerMock = TrendingBarRouterMock()
        interactorMock = TrendingBarInteractorMock()
        sut.router = routerMock
        sut.interactor = interactorMock
        trendingViewMock = TrendingBarViewControllerMock()
        sut.view = trendingViewMock
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        routerMock = nil
        trendingViewMock = nil
    }
    
    func test_didSelectRow_callsRouter() {
        let indexPath = IndexPath()
        
        sut.didSelectRowAt(indexPath)
        
        XCTAssertEqual(routerMock.calls, [.presentDetailViewController])
    }
    
    func test_presentSearchView_callsRouter() {
        sut.presentSearchView()
        
        XCTAssertEqual(routerMock.calls, [.presentMovieSearchViewController])
    }
    
    func test_reloadInfo_callsReloadTendingInfo() {
        sut.reloadInfo()
        
        XCTAssertEqual(trendingViewMock.calls, [.reloadTendingInfo])
    }
    
    func test_prepareActionSheet_callsShowAlert() {
        sut.prepareActionSheet()
        
        XCTAssertEqual(trendingViewMock.calls, [.showAlert])
    }
    
    func test_searchBy_callsInteractorFetchMovieList() {
        let filter = 1
        
        sut.search(byFilter: filter)
        
        XCTAssertEqual(interactorMock.calls, [.fetchMovieList])
    }
    
    func test_onReceivedTrendingList_callsInteractorFetchImageFrom() {
        let moviesResult = MovieFakes().movieResult
        
        sut.onReceivedTrendingList(with: moviesResult)
        
        XCTAssertEqual(interactorMock.calls, [.fetchImageFrom])
    }
    
    func test_onReceivedMovie_callsViewFillTrendingMovie(){
        let movie = Movie(id: 235, title: "prueba", posterPath: Data())
        
        sut.onReceivedMovie(with: movie)
        
        XCTAssertEqual(trendingViewMock.calls, [.fillTrendingList])
    }
    
    func test_onReceivedWithError_callsViewReloadWithError() {
        let error = ServiceError.internalServer
        
        sut.onReceived(with: error)
        
        XCTAssertEqual(trendingViewMock.calls, [.reloadWithError])
    }
}
