//
//  SearchViewMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import Foundation
import XCTest

@testable import BAZProject

final class SearchViewMock: SearchViewProtocol {
    
    var expectation: XCTestExpectation?
    var presenter: SearchPresenterProtocol?
    var reloadDataWasCalled: Bool = false
    
    func reloadData() {
        expectation?.fulfill()
        reloadDataWasCalled = true
    }
    
}

