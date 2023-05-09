//
//  DetailViewMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import Foundation
import XCTest

@testable import BAZProject

final class MovieDetailViewMock: MovieDetailViewProtocol {
    
    var expectation: XCTestExpectation?
    var presenter: MovieDetailPresenterProtocol?
    var reloadDataWasCalled: Bool = false
    
    func reloadData() {
        expectation?.fulfill()
        reloadDataWasCalled = true
    }
    
}
