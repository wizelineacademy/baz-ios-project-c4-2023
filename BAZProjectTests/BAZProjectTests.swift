//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 30/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {
    
    private var serviceMock: ServiceMock!
    private var sessionMock: URLSessionMock!
   
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        serviceMock = ServiceMock(sessionMock: sessionMock)
    }
    
    override func tearDown() {
        super.tearDown()
        sessionMock = nil
        sessionMock = nil
    }
}
