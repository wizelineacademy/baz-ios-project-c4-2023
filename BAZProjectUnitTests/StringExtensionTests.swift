//
//  StringExtensionTests.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 05/05/23.
//

import XCTest
@testable import BAZProject

final class StringExtensionTests: XCTestCase {
    
    func testToUrl() {
        let urlString = "https://www.google.com"
        let url = urlString.toUrl()
        XCTAssertNotNil(url)
        XCTAssertEqual(url, URL(string: urlString))
    }
    
    func testLocalized() {
        let localizedString = "moviesText".localized
        XCTAssertEqual(localizedString, "Peliculas")
    }
    
    func testFormatReleaseDate() {
        let releaseDateString = "2019-12-04"
        let formattedDateString = releaseDateString.formatReleaseDate()
        XCTAssertEqual(formattedDateString, "04/12/2019")
    }
    
    func testSetParameters() {
        let urlString = "https://www.example.com/{id}/popular?keyword=Dragon"
        let formattedUrlString = urlString.setParameters(old: "{id}", new: "1")
        XCTAssertEqual(formattedUrlString, "https://www.example.com/1/popular?keyword=Dragon")
    }
}
