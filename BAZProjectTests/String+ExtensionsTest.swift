//
//  String+ExtensionsTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import Foundation

import XCTest
@testable import BAZProject

/// The StringExtensionsTest class is responsible for testing the extension methods defined on the String class.
final class StringExtensionsTest: XCTestCase {
    
    // MARK: - Properties

    /// The subject under test.
    private var sut: String!
    
    // MARK: - Set up and tear down
    
    override func setUp() {
        super.setUp()

        // Set up the initial state of the subject under test.
        self.sut = "<b>Hola</b>"
    }
    
    override func tearDown() {
        // Clean up the state of the subject under test.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    
    /// Tests the `htmlToAttributedString` extension method of the `String` class.
    func testStringExtensions_checkHtmlToAttributedString() {
        XCTAssertNotNil(sut.htmlToAttributedString)
    }
}
