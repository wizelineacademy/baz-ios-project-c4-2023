//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by bvelazquezva on 29/03/23.
//

import XCTest
@testable import BAZProject

class BAZProjectTests: XCTestCase {
    
    typealias InteractorSearchProtocols = SearchInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol
    
    var trendingPresenter: TrendingPresenter?
    var trendingPresenterMock: TrendingPresenterMock?
    //MARK: Search Variables
    var searchPresenter: SearchPresenter?
    var interactorSearch: InteractorSearchProtocols?
    var remoteSearchDataManager: SearchRemoteDataManagerInputProtocol?
    var searchPresenterMock: SearchPresenterMock?
    var interactorSearchMock: InteractorSearchProtocols?
    var remoteSearchDataManagerMock: SearchRemoteDataManagerInputProtocol?
        
    var resulTrending: [Movie] = []
    var searchQuery = "John Wick"

    override func setUp(){
        super.setUp()
        trendingPresenter = TrendingPresenter()
        trendingPresenterMock = TrendingPresenterMock()
        
        createSearch()
        createSearchMock()
    }
    
    func createSearchMock(){
        searchPresenterMock = SearchPresenterMock(tableView: UITableView())
        interactorSearchMock = SearchInteractorMock()
        interactorSearchMock?.presenter = searchPresenterMock
        searchPresenterMock?.interactor = interactorSearchMock
        remoteSearchDataManagerMock = SearchRemoteDataManagerMock()
        interactorSearchMock?.remoteDatamanager = remoteSearchDataManagerMock
        remoteSearchDataManagerMock?.remoteRequestHandler = interactorSearchMock
    }
    
    func createSearch(){
        searchPresenter = SearchPresenter()
        interactorSearch = SearchInteractor()
        interactorSearch?.presenter = searchPresenter
        searchPresenter?.interactor = interactorSearch
        remoteSearchDataManager = SearchRemoteDataManager()
        guard let remoteSearchDataManager = remoteSearchDataManager else {return}
        interactorSearch?.remoteDatamanager = remoteSearchDataManager
        remoteSearchDataManager.remoteRequestHandler = interactorSearch
    }
    
    func denitSearchMock(){
        searchPresenter = nil
        searchPresenterMock = nil
        interactorSearchMock = nil
        remoteSearchDataManagerMock = nil
    }

    override func tearDown(){
        super.tearDown()
        trendingPresenter = nil
        trendingPresenterMock = nil
        
        denitSearchMock()
    }

    func test_DataMovieResponse(){
        //Give
        var expetationMovies: [Movie] = []
        trendingPresenterMock?.willFetchMovies()
        expetationMovies = trendingPresenterMock?.entity.result ?? []
        //When
        var result: [Movie] = []
        trendingPresenter?.willFetchMovies()
        result = trendingPresenter?.entity.result ?? []
        
        
        //Then
        XCTAssertEqual(expetationMovies, result)
    }
    
    func test_Data_NotNil(){
        //Give
        //When
        var result: [Movie] = []
        trendingPresenter?.willFetchMovies()
        result = trendingPresenter?.entity.result ?? []
        //Then
        XCTAssertNotNil(result)
    }
    
    func test_DataSearchMovieResponse() async{
        //Give
        let expectation = expectation(description: "Wait for completion status")
        var expetationMovies: [Movie] = []
        searchPresenterMock?.willFetchMovies(searchQuery)
        expetationMovies = searchPresenterMock?.entity.result ?? []
        print(expetationMovies)
        //When
        var result: [Movie] = []
        searchPresenter?.willFetchMovies(searchQuery)
        wait(for: [expectation], timeout: 6.0)
        result = searchPresenter?.entity.result ?? []
        expectation.fulfill()
        print(result)
        
        
        //Then
        XCTAssertEqual(expetationMovies, result)
    }
    
    func test_DataSearch_NotNil(){
        //Give
        //When
        var result: [Movie] = []
        searchPresenter?.willFetchMovies(searchQuery)
        result = searchPresenter?.entity.result ?? []
        //Then
        XCTAssertNotNil(result)
    }

}

/*func test_DataMovie(){
    //Give
    //When
    //Then
}*/
