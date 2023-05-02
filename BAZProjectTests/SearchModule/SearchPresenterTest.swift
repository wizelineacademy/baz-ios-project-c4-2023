//
//  SearchPresenterTest.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 26/04/23.
//

import Foundation
import XCTest

@testable import BAZProject

final class SearchPresenterTest : XCTestCase {
    
    var sut: (SearchPresenterProtocol & SearchInteractorOutputProtocol)?
    var interactorMock: SearchInteractorMock!
    
    override func setUp() {
        super.setUp()
        sut = SearchPresenter()
        interactorMock = SearchInteractorMock()
        sut?.interactor = interactorMock
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        interactorMock = nil
    }
    
}
