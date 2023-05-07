//
//  String+ExtensionsTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import Foundation

import XCTest
@testable import BAZProject

final class StringExtensionsTest: XCTestCase {

    private var sut: String!
    
    override func setUp() {
        super.setUp()

        self.sut = "<b>Hola</b>"
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testStringExtensions_checkHtmlToAttributedString() {
        XCTAssertNotNil(sut.htmlToAttributedString)
    }
}

