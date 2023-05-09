//
//  MockSearchRepository.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import Foundation
@testable import BAZProject

class MockSearchDelegate: SearchDelegate {
    var searchResultsCalled = false

    func searchResults() {
        searchResultsCalled = true
    }
}
