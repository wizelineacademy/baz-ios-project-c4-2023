//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by Sergio Del Olmo Aguilar on 31/03/23.
//

import XCTest
@testable import BAZProject

class BAZProjectTests: XCTestCase {
    
    var interactor: Interactor!
    var mockPresenter: MockPresenter!
        
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        interactor = Interactor()
        interactor.presenter = mockPresenter
    }
    
    func testGetMoviesData() {
        //Given
        let expectation = self.expectation(description: "Expecting API results")
        mockPresenter.manageResponseCalled = false
        
        //When
        interactor.getMoviesData()
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertTrue(self.mockPresenter.manageResponseCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
}

class MockPresenter: InteractorToPresenter {
    var manageResponseCalled = false
    var manageResponseResults: [Viewable]?
    
    func manageResponse(results: [Viewable]) {
        manageResponseCalled = true
        manageResponseResults = results
    }
}
