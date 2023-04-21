//
//  MovieSearchViewControllerTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import XCTest
@testable import BAZProject

final class MovieSearchViewControllerTests: XCTestCase {
    
    private var presenter: MovieSearchPresenterMock!
    private var sut: SearchMoviesViewController!

    override func setUp() {
        super.setUp()
        presenter = MovieSearchPresenterMock()
        sut = makeSUT()
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        super.tearDown()
    }
    
    func makeSUT() -> SearchMoviesViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchMoviesViewController
        sut.presenter = presenter
        sut.loadViewIfNeeded()
        return sut
    }
    
    func test_searchBarSearchButtonClicked_callsPresenterSearchMovie() {
        sut.searchBarSearchButtonClicked(UISearchBar())
        
        XCTAssertEqual(presenter.calls, [.searchMovie])
    }
    
    func test_fillMovieList_callsPresenterReloadInfo() {
        sut.fillMovieList()
        
        XCTAssertEqual(presenter.calls, [.reloadInfo])
    }
}
