//
//  MovieViewMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 25/04/23.
//

import Foundation
import XCTest

@testable import BAZProject

final class MovieViewMock: MovieViewProtocol {
    
    var expectation: XCTestExpectation?
    var presenter: MoviePresenterProtocol?
    var reloadDataWasCalled: Bool = false
    
    func reloadData() {
        expectation?.fulfill()
        reloadDataWasCalled = true
    }
    
}
