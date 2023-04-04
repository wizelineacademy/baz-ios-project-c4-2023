//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 30/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {

    private var sut: ServiceMock!
    private var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sut = ServiceMock(sessionMock: sessionMock)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        sessionMock = nil
    }

}
