//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 28/03/23.
//

import XCTest
@testable import BAZProject

class BAZProjectTests: XCTestCase {

    private var sut: ServiceMocks!
    private var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sut = ServiceMocks(sessionMock: sessionMock)
    }

    override func tearDown() {
        sut = nil
        sessionMock = nil
    }

}
