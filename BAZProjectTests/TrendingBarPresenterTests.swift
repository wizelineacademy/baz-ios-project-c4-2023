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
        
        XCTAssertEqual(routerMock.calls, [.presentNextViewController])
    }
    
    func test_presentSearchView_callsRouter() {
        sut.presentSearchView()
        
        XCTAssertEqual(routerMock.calls, [.presentNextViewController])
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
        let moviesResult = TrendingMoviesResult(page: 1, results: [MovieResult(adult: false, backdropPath: "/ovM06PdF3M8wvKb06i4sjW3xoww.jpg", id: 76600, title: "Avatar: El sentido del agua", originalLanguage: "en", originalTitle: "Avatar: The Way of Water", overview: "Ambientada más de una década después de los acontecimientos de la primera película, 'Avatar: The Way of Water' empieza contando la historia de la familia Sully (Jake, Neytiri y sus hijos), los problemas que los persiguen, lo que tienen que hacer para mantenerse a salvo, las batallas que libran para seguir con vida y las tragedias que sufren.", posterPath: "/kUAG4ZQcsNbRyiPyAr3hLdsVgAq.jpg", mediaType: "movie", genreIds: [878,12,28], popularity: 3464.178, releaseDate: "2022-12-14", video: false, voteAverage: 7.7, voteCount: 5985), MovieResult(adult: false, backdropPath: "/ovM06PdF3M8wvKb06i4sjW3xoww.jpg", id: 76600, title: "Avatar: El sentido del agua", originalLanguage: "en", originalTitle: "Avatar: The Way of Water", overview: "Ambientada más de una década después de los acontecimientos de la primera película, 'Avatar: The Way of Water' empieza contando la historia de la familia Sully (Jake, Neytiri y sus hijos), los problemas que los persiguen, lo que tienen que hacer para mantenerse a salvo, las batallas que libran para seguir con vida y las tragedias que sufren.", posterPath: "/kUAG4ZQcsNbRyiPyAr3hLdsVgAq.jpg", mediaType: "movie", genreIds: [878,12,28], popularity: 3464.178, releaseDate: "2022-12-14", video: false, voteAverage: 7.7, voteCount: 5985)], totalPages: 4, totalResults: 4)
        
        sut.onReceivedTrendingList(with: moviesResult)
        
        XCTAssertEqual(interactorMock.calls, [.fetchImageFrom, .fetchImageFrom])
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
