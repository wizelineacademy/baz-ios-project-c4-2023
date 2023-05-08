//
//  ResultTableViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest
@testable import BAZProject

final class ResultTableViewControllerTest: XCTestCase {
    private var sut: ResultsTableController!
    private var fakeMovies: [ListMovieProtocol]!
    private var fakeApi: FakeMovieApi!
    
    override func setUp() {
        super.setUp()
        sut = ResultsTableController()
        fakeMovies = []
        fakeApi = FakeMovieApi(resultType: .sucess)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovies = nil
    }
    
    func test_numberOfRowsInSection(){
        guard let url = MovieCategories.topRated.urlRequest else { return }
        fakeApi.fetch(request: url) {[weak self] (result: Result<MovieResult?, Error>) in
            switch result {
            case .success(let success):
                guard let expectedResult = success?.results else { return }
                self?.sut.filteredProducts = expectedResult
                let rowCount = self?.sut.tableView(self?.sut.tableView ?? UITableView(), numberOfRowsInSection: 10)
                XCTAssertEqual(rowCount, expectedResult.count)
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    
    func test_tableViewCellForRowAt(){
        guard let url = MovieCategories.topRated.urlRequest else { return }
        fakeApi.fetch(request: url) {[weak self] (result: Result<MovieResult?, Error>) in
            switch result {
            case .success(let success):
                guard let expectedResult = success?.results,
                        let title = expectedResult.first?.title else { return }
                self?.sut.filteredProducts = expectedResult
                self?.sut.tableView.reloadData()
                let cell = self?.sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                guard let cellTitle = cell?.textLabel?.text else { return }
                XCTAssertEqual(title, cellTitle)
            case .failure(let failure):
                print(failure)
            }
        }
        
        
    }

}
